// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cursor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CursorPrompt _$CursorPromptFromJson(Map<String, dynamic> json) => CursorPrompt(
      projectPath: json['projectPath'] as String,
      prompt: json['prompt'] as String,
      context: json['context'] as String?,
      files: (json['files'] as List<dynamic>?)?.map((e) => e as String).toList(),
      openInCursor: json['openInCursor'] as bool?,
    );

Map<String, dynamic> _$CursorPromptToJson(CursorPrompt instance) => <String, dynamic>{
      'projectPath': instance.projectPath,
      'prompt': instance.prompt,
      'context': instance.context,
      'files': instance.files,
      'openInCursor': instance.openInCursor,
    };

CursorCommand _$CursorCommandFromJson(Map<String, dynamic> json) => CursorCommand(
      projectPath: json['projectPath'] as String,
      command: json['command'] as String,
      args: (json['args'] as List<dynamic>?)?.map((e) => e as String).toList(),
      workingDirectory: json['workingDirectory'] as String?,
    );

Map<String, dynamic> _$CursorCommandToJson(CursorCommand instance) => <String, dynamic>{
      'projectPath': instance.projectPath,
      'command': instance.command,
      'args': instance.args,
      'workingDirectory': instance.workingDirectory,
    };

CursorOpen _$CursorOpenFromJson(Map<String, dynamic> json) => CursorOpen(
      projectPath: json['projectPath'] as String,
      file: json['file'] as String?,
      line: json['line'] as int?,
      column: json['column'] as int?,
    );

Map<String, dynamic> _$CursorOpenToJson(CursorOpen instance) => <String, dynamic>{
      'projectPath': instance.projectPath,
      'file': instance.file,
      'line': instance.line,
      'column': instance.column,
    };

CursorResponse _$CursorResponseFromJson(Map<String, dynamic> json) => CursorResponse(
      id: json['id'] as String,
      status: $enumDecode(_$CursorStatusEnumMap, json['status']),
      result: json['result'] as String?,
      error: json['error'] as String?,
      timestamp: json['timestamp'] as String,
      duration: json['duration'] as int?,
    );

Map<String, dynamic> _$CursorResponseToJson(CursorResponse instance) => <String, dynamic>{
      'id': instance.id,
      'status': _$CursorStatusEnumMap[instance.status],
      'result': instance.result,
      'error': instance.error,
      'timestamp': instance.timestamp,
      'duration': instance.duration,
    };

const _$CursorStatusEnumMap = {
  CursorStatus.pending: 'pending',
  CursorStatus.running: 'running',
  CursorStatus.completed: 'completed',
  CursorStatus.error: 'error',
};

CursorStatusRequest _$CursorStatusRequestFromJson(Map<String, dynamic> json) => CursorStatusRequest(
      projectPath: json['projectPath'] as String,
    );

Map<String, dynamic> _$CursorStatusRequestToJson(CursorStatusRequest instance) => <String, dynamic>{
      'projectPath': instance.projectPath,
    };
