import 'package:json_annotation/json_annotation.dart';

part 'git.g.dart';

@JsonSerializable()
class GitStatus {
  final String projectPath;
  final String? currentBranch;
  final bool? isClean;
  final List<GitFileStatus>? files;
  final int? aheadCount;
  final int? behindCount;

  const GitStatus({
    required this.projectPath,
    this.currentBranch,
    this.isClean,
    this.files,
    this.aheadCount,
    this.behindCount,
  });

  factory GitStatus.fromJson(Map<String, dynamic> json) => 
      _$GitStatusFromJson(json);
  Map<String, dynamic> toJson() => _$GitStatusToJson(this);
}

@JsonSerializable()
class GitFileStatus {
  final String file;
  final String status;
  final String? staged;

  const GitFileStatus({
    required this.file,
    required this.status,
    this.staged,
  });

  factory GitFileStatus.fromJson(Map<String, dynamic> json) => 
      _$GitFileStatusFromJson(json);
  Map<String, dynamic> toJson() => _$GitFileStatusToJson(this);
}

@JsonSerializable()
class GitDiff {
  final String projectPath;
  final String? file;
  final String? commit;
  final List<GitDiffInfo>? diffs;

  const GitDiff({
    required this.projectPath,
    this.file,
    this.commit,
    this.diffs,
  });

  factory GitDiff.fromJson(Map<String, dynamic> json) => 
      _$GitDiffFromJson(json);
  Map<String, dynamic> toJson() => _$GitDiffToJson(this);
}

@JsonSerializable()
class GitDiffInfo {
  final String file;
  final String diff;
  final String? status;

  const GitDiffInfo({
    required this.file,
    required this.diff,
    this.status,
  });

  factory GitDiffInfo.fromJson(Map<String, dynamic> json) => 
      _$GitDiffInfoFromJson(json);
  Map<String, dynamic> toJson() => _$GitDiffInfoToJson(this);
}

@JsonSerializable()
class GitCommit {
  final String projectPath;
  final String message;
  final List<String>? files;
  final bool? all;

  const GitCommit({
    required this.projectPath,
    required this.message,
    this.files,
    this.all,
  });

  factory GitCommit.fromJson(Map<String, dynamic> json) => 
      _$GitCommitFromJson(json);
  Map<String, dynamic> toJson() => _$GitCommitToJson(this);
}

@JsonSerializable()
class GitLog {
  final String projectPath;
  final String? since;
  final String? until;
  final String? author;
  final String? file;
  final int? limit;
  final List<GitCommitInfo>? commits;

  const GitLog({
    required this.projectPath,
    this.since,
    this.until,
    this.author,
    this.file,
    this.limit,
    this.commits,
  });

  factory GitLog.fromJson(Map<String, dynamic> json) => 
      _$GitLogFromJson(json);
  Map<String, dynamic> toJson() => _$GitLogToJson(this);
}

@JsonSerializable()
class GitCommitInfo {
  final String hash;
  final String message;
  final String author;
  final String date;
  final String? email;

  const GitCommitInfo({
    required this.hash,
    required this.message,
    required this.author,
    required this.date,
    this.email,
  });

  factory GitCommitInfo.fromJson(Map<String, dynamic> json) => 
      _$GitCommitInfoFromJson(json);
  Map<String, dynamic> toJson() => _$GitCommitInfoToJson(this);
}

@JsonSerializable()
class GitBranch {
  final String projectPath;
  final String? branch;
  final List<String>? branches;
  final String? current;

  const GitBranch({
    required this.projectPath,
    this.branch,
    this.branches,
    this.current,
  });

  factory GitBranch.fromJson(Map<String, dynamic> json) => 
      _$GitBranchFromJson(json);
  Map<String, dynamic> toJson() => _$GitBranchToJson(this);
}

@JsonSerializable()
class GitCheckout {
  final String projectPath;
  final String branch;

  const GitCheckout({
    required this.projectPath,
    required this.branch,
  });

  factory GitCheckout.fromJson(Map<String, dynamic> json) => 
      _$GitCheckoutFromJson(json);
  Map<String, dynamic> toJson() => _$GitCheckoutToJson(this);
}

@JsonSerializable()
class GitPull {
  final String projectPath;
  final String? remote;
  final String? branch;

  const GitPull({
    required this.projectPath,
    this.remote,
    this.branch,
  });

  factory GitPull.fromJson(Map<String, dynamic> json) => 
      _$GitPullFromJson(json);
  Map<String, dynamic> toJson() => _$GitPullToJson(this);
}

@JsonSerializable()
class GitPush {
  final String projectPath;
  final String? remote;
  final String? branch;

  const GitPush({
    required this.projectPath,
    this.remote,
    this.branch,
  });

  factory GitPush.fromJson(Map<String, dynamic> json) => 
      _$GitPushFromJson(json);
  Map<String, dynamic> toJson() => _$GitPushToJson(this);
}
