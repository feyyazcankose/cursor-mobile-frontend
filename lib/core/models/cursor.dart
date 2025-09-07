import 'package:json_annotation/json_annotation.dart';

part 'cursor.g.dart';

@JsonSerializable()
class CursorPrompt {
  final String projectPath;
  final String prompt;
  final String? context;
  final List<String>? files;
  final bool? openInCursor;

  const CursorPrompt({
    required this.projectPath,
    required this.prompt,
    this.context,
    this.files,
    this.openInCursor,
  });

  factory CursorPrompt.fromJson(Map<String, dynamic> json) => 
      _$CursorPromptFromJson(json);
  Map<String, dynamic> toJson() => _$CursorPromptToJson(this);
}

@JsonSerializable()
class CursorCommand {
  final String projectPath;
  final String command;
  final List<String>? args;
  final String? workingDirectory;

  const CursorCommand({
    required this.projectPath,
    required this.command,
    this.args,
    this.workingDirectory,
  });

  factory CursorCommand.fromJson(Map<String, dynamic> json) => 
      _$CursorCommandFromJson(json);
  Map<String, dynamic> toJson() => _$CursorCommandToJson(this);
}

@JsonSerializable()
class CursorOpen {
  final String projectPath;
  final String? file;
  final int? line;
  final int? column;

  const CursorOpen({
    required this.projectPath,
    this.file,
    this.line,
    this.column,
  });

  factory CursorOpen.fromJson(Map<String, dynamic> json) => 
      _$CursorOpenFromJson(json);
  Map<String, dynamic> toJson() => _$CursorOpenToJson(this);
}

@JsonSerializable()
class CursorResponse {
  final String id;
  final CursorStatus status;
  final String? result;
  final String? error;
  final String timestamp;
  final int? duration;

  const CursorResponse({
    required this.id,
    required this.status,
    this.result,
    this.error,
    required this.timestamp,
    this.duration,
  });

  factory CursorResponse.fromJson(Map<String, dynamic> json) => 
      _$CursorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CursorResponseToJson(this);

  bool get isCompleted => status == CursorStatus.completed;
  bool get isRunning => status == CursorStatus.running;
  bool get isPending => status == CursorStatus.pending;
  bool get hasError => status == CursorStatus.error;
}

@JsonEnum()
enum CursorStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('running')
  running,
  @JsonValue('completed')
  completed,
  @JsonValue('error')
  error,
}

@JsonSerializable()
class CursorStatusRequest {
  final String projectPath;

  const CursorStatusRequest({
    required this.projectPath,
  });

  factory CursorStatusRequest.fromJson(Map<String, dynamic> json) => 
      _$CursorStatusRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CursorStatusRequestToJson(this);
}
