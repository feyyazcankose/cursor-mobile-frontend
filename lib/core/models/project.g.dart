// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      name: json['name'] as String,
      path: json['path'] as String,
      description: json['description'] as String?,
      lastModified: json['lastModified'] as String?,
      fileCount: json['fileCount'] as int?,
      gitBranch: json['gitBranch'] as String?,
      gitStatus: json['gitStatus'] as String?,
      language: json['language'] as String?,
      framework: json['framework'] as String?,
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'name': instance.name,
      'path': instance.path,
      'description': instance.description,
      'lastModified': instance.lastModified,
      'fileCount': instance.fileCount,
      'gitBranch': instance.gitBranch,
      'gitStatus': instance.gitStatus,
      'language': instance.language,
      'framework': instance.framework,
    };

ProjectListRequest _$ProjectListRequestFromJson(Map<String, dynamic> json) =>
    ProjectListRequest(
      path: json['path'] as String,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ProjectListRequestToJson(ProjectListRequest instance) =>
    <String, dynamic>{
      'path': instance.path,
      'name': instance.name,
    };
