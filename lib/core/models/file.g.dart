// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileItem _$FileItemFromJson(Map<String, dynamic> json) => FileItem(
      name: json['name'] as String,
      path: json['path'] as String,
      relativePath: json['relativePath'] as String,
      content: json['content'] as String?,
      type: json['type'] as String?,
      size: json['size'] as int?,
      lastModified: json['lastModified'] as String?,
      isDirectory: json['isDirectory'] as bool?,
      language: json['language'] as String?,
    );

Map<String, dynamic> _$FileItemToJson(FileItem instance) => <String, dynamic>{
      'name': instance.name,
      'path': instance.path,
      'relativePath': instance.relativePath,
      'content': instance.content,
      'type': instance.type,
      'size': instance.size,
      'lastModified': instance.lastModified,
      'isDirectory': instance.isDirectory,
      'language': instance.language,
    };

FileListRequest _$FileListRequestFromJson(Map<String, dynamic> json) =>
    FileListRequest(
      projectPath: json['projectPath'] as String,
      directoryPath: json['directoryPath'] as String?,
    );

Map<String, dynamic> _$FileListRequestToJson(FileListRequest instance) =>
    <String, dynamic>{
      'projectPath': instance.projectPath,
      'directoryPath': instance.directoryPath,
    };

FileContentRequest _$FileContentRequestFromJson(Map<String, dynamic> json) =>
    FileContentRequest(
      projectPath: json['projectPath'] as String,
      filePath: json['filePath'] as String,
    );

Map<String, dynamic> _$FileContentRequestToJson(FileContentRequest instance) =>
    <String, dynamic>{
      'projectPath': instance.projectPath,
      'filePath': instance.filePath,
    };

FileWriteRequest _$FileWriteRequestFromJson(Map<String, dynamic> json) =>
    FileWriteRequest(
      projectPath: json['projectPath'] as String,
      filePath: json['filePath'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$FileWriteRequestToJson(FileWriteRequest instance) =>
    <String, dynamic>{
      'projectPath': instance.projectPath,
      'filePath': instance.filePath,
      'content': instance.content,
    };
