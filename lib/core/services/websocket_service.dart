import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/websocket.dart';

part 'websocket_service.g.dart';

@riverpod
class WebSocketService extends _$WebSocketService {
  WebSocketChannel? _channel;
  Timer? _pingTimer;
  bool _isConnected = false;
  final StreamController<WebSocketEvent> _eventController = StreamController.broadcast();

  @override
  Stream<WebSocketEvent> build() {
    return _eventController.stream;
  }

  bool get isConnected => _isConnected;

  Future<void> connect(String url, {String? apiKey}) async {
    try {
      // Close existing connection
      await disconnect();

      // Create WebSocket URL
      final uri = Uri.parse(url.replaceFirst('http', 'ws'));
      final wsUrl = '${uri.scheme}://${uri.host}:${uri.port}/mobile';
      
      // Add API key if provided
      final headers = <String, dynamic>{};
      if (apiKey != null && apiKey.isNotEmpty) {
        headers['X-API-Key'] = apiKey;
      }

      _channel = WebSocketChannel.connect(
        Uri.parse(wsUrl),
        protocols: ['mobile'],
        headers: headers,
      );

      // Listen to messages
      _channel!.stream.listen(
        _handleMessage,
        onError: _handleError,
        onDone: _handleDisconnect,
      );

      _isConnected = true;
      _startPingTimer();
      
      print('[WebSocket] Connected to $wsUrl');
    } catch (e) {
      print('[WebSocket] Connection failed: $e');
      _isConnected = false;
      rethrow;
    }
  }

  Future<void> disconnect() async {
    _pingTimer?.cancel();
    _pingTimer = null;
    
    await _channel?.sink.close();
    _channel = null;
    _isConnected = false;
    
    print('[WebSocket] Disconnected');
  }

  void _handleMessage(dynamic message) {
    try {
      final data = jsonDecode(message);
      final event = WebSocketEvent.fromJson(data);
      _eventController.add(event);
    } catch (e) {
      print('[WebSocket] Error parsing message: $e');
    }
  }

  void _handleError(error) {
    print('[WebSocket] Error: $error');
    _isConnected = false;
  }

  void _handleDisconnect() {
    print('[WebSocket] Connection closed');
    _isConnected = false;
  }

  void _startPingTimer() {
    _pingTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (_isConnected && _channel != null) {
        sendPing();
      }
    });
  }

  // WebSocket Events
  void joinProject(String projectPath) {
    _sendMessage('join_project', {'projectPath': projectPath});
  }

  void leaveProject(String projectPath) {
    _sendMessage('leave_project', {'projectPath': projectPath});
  }

  void subscribeFileChanges(String projectPath) {
    _sendMessage('subscribe_file_changes', {'projectPath': projectPath});
  }

  void unsubscribeFileChanges(String projectPath) {
    _sendMessage('unsubscribe_file_changes', {'projectPath': projectPath});
  }

  void subscribeCursorUpdates({String? projectPath}) {
    _sendMessage('subscribe_cursor_updates', {'projectPath': projectPath});
  }

  void unsubscribeCursorUpdates({String? projectPath}) {
    _sendMessage('unsubscribe_cursor_updates', {'projectPath': projectPath});
  }

  void sendPing() {
    _sendMessage('ping', {});
  }

  void _sendMessage(String type, Map<String, dynamic> data) {
    if (_channel != null && _isConnected) {
      final message = {
        'type': type,
        'data': data,
        'timestamp': DateTime.now().toIso8601String(),
      };
      
      _channel!.sink.add(jsonEncode(message));
    }
  }

  // Specific event streams
  Stream<FileChangeEvent> get fileChangeEvents {
    return _eventController.stream
        .where((event) => event.type == 'file_change')
        .map((event) => FileChangeEvent.fromJson(event.data));
  }

  Stream<CursorUpdateEvent> get cursorUpdateEvents {
    return _eventController.stream
        .where((event) => event.type == 'cursor_update')
        .map((event) => CursorUpdateEvent.fromJson(event.data));
  }

  Stream<ProjectUpdateEvent> get projectUpdateEvents {
    return _eventController.stream
        .where((event) => event.type == 'project_update')
        .map((event) => ProjectUpdateEvent.fromJson(event.data));
  }

  Stream<GitUpdateEvent> get gitUpdateEvents {
    return _eventController.stream
        .where((event) => event.type == 'git_update')
        .map((event) => GitUpdateEvent.fromJson(event.data));
  }

  Stream<ConnectionEvent> get connectionEvents {
    return _eventController.stream
        .where((event) => event.type == 'connected')
        .map((event) => ConnectionEvent.fromJson(event.data));
  }

  Stream<PongEvent> get pongEvents {
    return _eventController.stream
        .where((event) => event.type == 'pong')
        .map((event) => PongEvent.fromJson(event.data));
  }

  @override
  void dispose() {
    disconnect();
    _eventController.close();
    super.dispose();
  }
}
