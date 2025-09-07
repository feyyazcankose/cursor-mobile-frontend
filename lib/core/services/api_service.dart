import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/project.dart';
import '../models/file.dart';
import '../models/cursor.dart';
import '../models/git.dart';
import '../models/activity.dart';

part 'api_service.g.dart';

@riverpod
class ApiService extends _$ApiService {
  late final Dio _dio;

  @override
  Dio build() {
    _dio = Dio();
    _dio.options.baseUrl = 'http://192.168.1.42:3001';
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    
    // Add interceptors
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (object) => print('[API] $object'),
    ));
    
    return _dio;
  }

  void updateBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  void setApiKey(String? apiKey) {
    if (apiKey != null && apiKey.isNotEmpty) {
      _dio.options.headers['X-API-Key'] = apiKey;
    } else {
      _dio.options.headers.remove('X-API-Key');
    }
  }

  // Projects API
  Future<List<Project>> getProjects() async {
    try {
      final response = await _dio.get('/projects');
      return (response.data as List)
          .map((json) => Project.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<Project>> scanProjects() async {
    try {
      final response = await _dio.get('/projects/scan');
      return (response.data as List)
          .map((json) => Project.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Project> getProject(String path) async {
    try {
      final response = await _dio.get('/projects/$path');
      return Project.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> refreshProject(String path) async {
    try {
      await _dio.post('/projects/$path/refresh');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Files API
  Future<List<FileItem>> getFiles(FileListRequest request) async {
    try {
      final response = await _dio.get('/files/list', queryParameters: request.toJson());
      return (response.data as List)
          .map((json) => FileItem.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<FileItem> getFileContent(FileContentRequest request) async {
    try {
      final response = await _dio.get('/files/content', queryParameters: request.toJson());
      return FileItem.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> writeFile(FileWriteRequest request) async {
    try {
      await _dio.post('/files/write', data: request.toJson());
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> deleteFile(String path) async {
    try {
      await _dio.delete('/files/$path');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> createDirectory(String path) async {
    try {
      await _dio.post('/files/directory', data: {'path': path});
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Cursor API
  Future<CursorResponse> sendPrompt(CursorPrompt prompt) async {
    try {
      final response = await _dio.post('/cursor/prompt', data: prompt.toJson());
      return CursorResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<CursorResponse> executeCommand(CursorCommand command) async {
    try {
      final response = await _dio.post('/cursor/command', data: command.toJson());
      return CursorResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> openInCursor(CursorOpen open) async {
    try {
      await _dio.post('/cursor/open', data: open.toJson());
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<CursorResponse>> getCursorResponses() async {
    try {
      final response = await _dio.get('/cursor/responses');
      return (response.data as List)
          .map((json) => CursorResponse.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<CursorResponse> getCursorResponse(String id) async {
    try {
      final response = await _dio.get('/cursor/response/$id');
      return CursorResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> cancelCursorResponse(String id) async {
    try {
      await _dio.post('/cursor/cancel/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Git API
  Future<GitStatus> getGitStatus(String projectPath) async {
    try {
      final response = await _dio.get('/git/status', queryParameters: {'projectPath': projectPath});
      return GitStatus.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<GitDiff> getGitDiff(String projectPath, {String? file, String? commit}) async {
    try {
      final queryParams = <String, dynamic>{'projectPath': projectPath};
      if (file != null) queryParams['file'] = file;
      if (commit != null) queryParams['commit'] = commit;
      
      final response = await _dio.get('/git/diff', queryParameters: queryParams);
      return GitDiff.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> createCommit(GitCommit commit) async {
    try {
      await _dio.post('/git/commit', data: commit.toJson());
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<GitLog> getGitLog(String projectPath, {String? since, String? until, String? author, String? file, int? limit}) async {
    try {
      final queryParams = <String, dynamic>{'projectPath': projectPath};
      if (since != null) queryParams['since'] = since;
      if (until != null) queryParams['until'] = until;
      if (author != null) queryParams['author'] = author;
      if (file != null) queryParams['file'] = file;
      if (limit != null) queryParams['limit'] = limit;
      
      final response = await _dio.get('/git/log', queryParameters: queryParams);
      return GitLog.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<GitBranch> getGitBranches(String projectPath) async {
    try {
      final response = await _dio.get('/git/branches', queryParameters: {'projectPath': projectPath});
      return GitBranch.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> checkoutBranch(String projectPath, String branch) async {
    try {
      await _dio.post('/git/checkout', data: {'projectPath': projectPath, 'branch': branch});
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> pullChanges(String projectPath, {String? remote, String? branch}) async {
    try {
      final data = <String, dynamic>{'projectPath': projectPath};
      if (remote != null) data['remote'] = remote;
      if (branch != null) data['branch'] = branch;
      
      await _dio.post('/git/pull', data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> pushChanges(String projectPath, {String? remote, String? branch}) async {
    try {
      final data = <String, dynamic>{'projectPath': projectPath};
      if (remote != null) data['remote'] = remote;
      if (branch != null) data['branch'] = branch;
      
      await _dio.post('/git/push', data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Health check
  Future<bool> checkConnection() async {
    try {
      await _dio.get('/health');
      return true;
    } catch (e) {
      return false;
    }
  }

  Exception _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Connection timeout. Please check your network connection.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data?['message'] ?? 'Server error';
        return Exception('Server error ($statusCode): $message');
      case DioExceptionType.cancel:
        return Exception('Request was cancelled');
      case DioExceptionType.connectionError:
        return Exception('Connection error. Please check if the server is running.');
      default:
        return Exception('An unexpected error occurred: ${e.message}');
    }
  }
}
