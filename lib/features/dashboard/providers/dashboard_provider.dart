import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/models/project.dart';
import '../../../core/services/api_service.dart';

part 'dashboard_provider.g.dart';

@riverpod
Future<List<Project>> projects(ProjectsRef ref) async {
  final apiService = ref.read(apiServiceProvider.notifier);
  return await apiService.getProjects();
}

@riverpod
List<Project> filteredProjects(FilteredProjectsRef ref, String query) {
  final projectsAsync = ref.watch(projectsProvider);
  
  return projectsAsync.when(
    data: (projects) {
      if (query.isEmpty) return projects;
      
      final lowercaseQuery = query.toLowerCase();
      return projects.where((project) {
        return project.name.toLowerCase().contains(lowercaseQuery) ||
               (project.description?.toLowerCase().contains(lowercaseQuery) ?? false) ||
               project.path.toLowerCase().contains(lowercaseQuery) ||
               (project.language?.toLowerCase().contains(lowercaseQuery) ?? false) ||
               (project.framework?.toLowerCase().contains(lowercaseQuery) ?? false);
      }).toList();
    },
    loading: () => [],
    error: (_, __) => [],
  );
}
