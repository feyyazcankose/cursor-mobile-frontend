import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/models/project.dart';
import '../../../core/services/api_service.dart';

part 'project_provider.g.dart';

@riverpod
Future<Project> project(ProjectRef ref, String projectPath) async {
  final apiService = ref.read(apiServiceProvider.notifier);
  return await apiService.getProject(projectPath);
}
