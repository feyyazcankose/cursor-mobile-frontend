import 'package:json_annotation/json_annotation.dart';

part 'websocket.g.dart';

@JsonSerializable()
class WebSocketEvent {
  final String type;
  final Map<String, dynamic> data;
  final String timestamp;

  const WebSocketEvent({
    required this.type,
    required this.data,
    required this.timestamp,
  });

  factory WebSocketEvent.fromJson(Map<String, dynamic> json) => 
      _$WebSocketEventFromJson(json);
  Map<String, dynamic> toJson() => _$WebSocketEventToJson(this);
}

@JsonSerializable()
class FileChangeEvent {
  final String event;
  final String filePath;
  final String projectPath;
  final String timestamp;

  const FileChangeEvent({
    required this.event,
    required this.filePath,
    required this.projectPath,
    required this.timestamp,
  });

  factory FileChangeEvent.fromJson(Map<String, dynamic> json) => 
      _$FileChangeEventFromJson(json);
  Map<String, dynamic> toJson() => _$FileChangeEventToJson(this);
}

@JsonSerializable()
class CursorUpdateEvent {
  final String id;
  final String status;
  final String? result;
  final String? error;
  final String timestamp;
  final int? duration;

  const CursorUpdateEvent({
    required this.id,
    required this.status,
    this.result,
    this.error,
    required this.timestamp,
    this.duration,
  });

  factory CursorUpdateEvent.fromJson(Map<String, dynamic> json) => 
      _$CursorUpdateEventFromJson(json);
  Map<String, dynamic> toJson() => _$CursorUpdateEventToJson(this);
}

@JsonSerializable()
class ProjectUpdateEvent {
  final String projectPath;
  final String action;
  final String timestamp;

  const ProjectUpdateEvent({
    required this.projectPath,
    required this.action,
    required this.timestamp,
  });

  factory ProjectUpdateEvent.fromJson(Map<String, dynamic> json) => 
      _$ProjectUpdateEventFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectUpdateEventToJson(this);
}

@JsonSerializable()
class GitUpdateEvent {
  final String projectPath;
  final String action;
  final String timestamp;
  final Map<String, dynamic>? details;

  const GitUpdateEvent({
    required this.projectPath,
    required this.action,
    required this.timestamp,
    this.details,
  });

  factory GitUpdateEvent.fromJson(Map<String, dynamic> json) => 
      _$GitUpdateEventFromJson(json);
  Map<String, dynamic> toJson() => _$GitUpdateEventToJson(this);
}

@JsonSerializable()
class ConnectionEvent {
  final String message;
  final String clientId;
  final String timestamp;

  const ConnectionEvent({
    required this.message,
    required this.clientId,
    required this.timestamp,
  });

  factory ConnectionEvent.fromJson(Map<String, dynamic> json) => 
      _$ConnectionEventFromJson(json);
  Map<String, dynamic> toJson() => _$ConnectionEventToJson(this);
}

@JsonSerializable()
class PongEvent {
  final String timestamp;

  const PongEvent({
    required this.timestamp,
  });

  factory PongEvent.fromJson(Map<String, dynamic> json) => 
      _$PongEventFromJson(json);
  Map<String, dynamic> toJson() => _$PongEventToJson(this);
}
