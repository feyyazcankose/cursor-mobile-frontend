import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

@JsonSerializable()
class Project {
  final String name;
  final String path;
  final String? description;
  final String? lastModified;
  final int? fileCount;
  final String? gitBranch;
  final String? gitStatus;
  final String? language;
  final String? framework;

  const Project({
    required this.name,
    required this.path,
    this.description,
    this.lastModified,
    this.fileCount,
    this.gitBranch,
    this.gitStatus,
    this.language,
    this.framework,
  });

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectToJson(this);

  Project copyWith({
    String? name,
    String? path,
    String? description,
    String? lastModified,
    int? fileCount,
    String? gitBranch,
    String? gitStatus,
    String? language,
    String? framework,
  }) {
    return Project(
      name: name ?? this.name,
      path: path ?? this.path,
      description: description ?? this.description,
      lastModified: lastModified ?? this.lastModified,
      fileCount: fileCount ?? this.fileCount,
      gitBranch: gitBranch ?? this.gitBranch,
      gitStatus: gitStatus ?? this.gitStatus,
      language: language ?? this.language,
      framework: framework ?? this.framework,
    );
  }

  bool get isRunning => gitStatus == 'running' || gitStatus == 'active';
  bool get hasUncommittedChanges => gitStatus == 'modified' || gitStatus == 'staged';
}

@JsonSerializable()
class ProjectListRequest {
  final String path;
  final String? name;

  const ProjectListRequest({
    required this.path,
    this.name,
  });

  factory ProjectListRequest.fromJson(Map<String, dynamic> json) => 
      _$ProjectListRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectListRequestToJson(this);
}
