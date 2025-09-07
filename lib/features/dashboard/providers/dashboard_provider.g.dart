// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$projectsHash() => r'2222222222222222';

/// See also [projects].
@ProviderFor(Future<List<Project>>)
final projectsProvider = AutoDisposeFutureProvider<List<Project>>.internal(
  projects,
  name: r'projectsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$projectsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

String _$filteredProjectsHash() => r'3333333333333333';

/// See also [filteredProjects].
@ProviderFor(List<Project>)
final filteredProjectsProvider = AutoDisposeProvider.family<List<Project>, String>.internal(
  filteredProjects,
  name: r'filteredProjectsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredProjectsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FilteredProjectsRef = AutoDisposeProviderRef<List<Project>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
