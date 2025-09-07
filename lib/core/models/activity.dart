import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable()
class ActivityItem {
  final String id;
  final ActivityType type;
  final String title;
  final String? description;
  final String? projectPath;
  final String? projectName;
  final String timestamp;
  final ActivityStatus status;
  final Map<String, dynamic>? metadata;

  const ActivityItem({
    required this.id,
    required this.type,
    required this.title,
    this.description,
    this.projectPath,
    this.projectName,
    required this.timestamp,
    required this.status,
    this.metadata,
  });

  factory ActivityItem.fromJson(Map<String, dynamic> json) => 
      _$ActivityItemFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityItemToJson(this);
}

@JsonEnum()
enum ActivityType {
  @JsonValue('prompt')
  prompt,
  @JsonValue('file')
  file,
  @JsonValue('server')
  server,
  @JsonValue('git')
  git,
  @JsonValue('project')
  project,
}

@JsonEnum()
enum ActivityStatus {
  @JsonValue('completed')
  completed,
  @JsonValue('running')
  running,
  @JsonValue('failed')
  failed,
  @JsonValue('pending')
  pending,
}

@JsonSerializable()
class ActivityFilter {
  final ActivityType? type;
  final String? projectPath;
  final DateTime? since;
  final DateTime? until;
  final int? limit;

  const ActivityFilter({
    this.type,
    this.projectPath,
    this.since,
    this.until,
    this.limit,
  });

  factory ActivityFilter.fromJson(Map<String, dynamic> json) => 
      _$ActivityFilterFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityFilterToJson(this);
}

@JsonSerializable()
class ActivityGroup {
  final String date;
  final List<ActivityItem> items;

  const ActivityGroup({
    required this.date,
    required this.items,
  });

  factory ActivityGroup.fromJson(Map<String, dynamic> json) => 
      _$ActivityGroupFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityGroupToJson(this);
}
