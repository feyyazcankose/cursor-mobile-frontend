import 'package:json_annotation/json_annotation.dart';

part 'file.g.dart';

@JsonSerializable()
class FileItem {
  final String name;
  final String path;
  final String relativePath;
  final String? content;
  final String? type;
  final int? size;
  final String? lastModified;
  final bool? isDirectory;
  final String? language;

  const FileItem({
    required this.name,
    required this.path,
    required this.relativePath,
    this.content,
    this.type,
    this.size,
    this.lastModified,
    this.isDirectory,
    this.language,
  });

  factory FileItem.fromJson(Map<String, dynamic> json) => _$FileItemFromJson(json);
  Map<String, dynamic> toJson() => _$FileItemToJson(this);

  FileItem copyWith({
    String? name,
    String? path,
    String? relativePath,
    String? content,
    String? type,
    int? size,
    String? lastModified,
    bool? isDirectory,
    String? language,
  }) {
    return FileItem(
      name: name ?? this.name,
      path: path ?? this.path,
      relativePath: relativePath ?? this.relativePath,
      content: content ?? this.content,
      type: type ?? this.type,
      size: size ?? this.size,
      lastModified: lastModified ?? this.lastModified,
      isDirectory: isDirectory ?? this.isDirectory,
      language: language ?? this.language,
    );
  }

  bool get isFile => !(isDirectory ?? false);
  bool get isFolder => isDirectory ?? false;
  
  String get displaySize {
    if (size == null) return '';
    if (size! < 1024) return '${size!}B';
    if (size! < 1024 * 1024) return '${(size! / 1024).toStringAsFixed(1)}KB';
    return '${(size! / (1024 * 1024)).toStringAsFixed(1)}MB';
  }
}

@JsonSerializable()
class FileListRequest {
  final String projectPath;
  final String? directoryPath;

  const FileListRequest({
    required this.projectPath,
    this.directoryPath,
  });

  factory FileListRequest.fromJson(Map<String, dynamic> json) => 
      _$FileListRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FileListRequestToJson(this);
}

@JsonSerializable()
class FileContentRequest {
  final String projectPath;
  final String filePath;

  const FileContentRequest({
    required this.projectPath,
    required this.filePath,
  });

  factory FileContentRequest.fromJson(Map<String, dynamic> json) => 
      _$FileContentRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FileContentRequestToJson(this);
}

@JsonSerializable()
class FileWriteRequest {
  final String projectPath;
  final String filePath;
  final String content;

  const FileWriteRequest({
    required this.projectPath,
    required this.filePath,
    required this.content,
  });

  factory FileWriteRequest.fromJson(Map<String, dynamic> json) => 
      _$FileWriteRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FileWriteRequestToJson(this);
}
