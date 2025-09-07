import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/connect/screens/connect_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/project/screens/project_detail_screen.dart';
import '../../features/files/screens/files_screen.dart';
import '../../features/files/screens/file_viewer_screen.dart';
import '../../features/prompts/screens/prompts_screen.dart';
import '../../features/prompts/screens/prompt_editor_screen.dart';
import '../../features/activity/screens/activity_screen.dart';
import '../../features/preview/screens/preview_screen.dart';
import '../../features/settings/screens/settings_screen.dart';

part 'app_router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(
    initialLocation: '/connect',
    routes: [
      // Connect Screen
      GoRoute(
        path: '/connect',
        name: 'connect',
        builder: (context, state) => const ConnectScreen(),
      ),
      
      // Main App with Bottom Navigation
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          // Dashboard
          GoRoute(
            path: '/dashboard',
            name: 'dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),
          
          // Activity
          GoRoute(
            path: '/activity',
            name: 'activity',
            builder: (context, state) => const ActivityScreen(),
          ),
          
          // Settings
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
      
      // Project Detail
      GoRoute(
        path: '/project/:projectPath',
        name: 'project',
        builder: (context, state) {
          final projectPath = state.pathParameters['projectPath']!;
          return ProjectDetailScreen(projectPath: projectPath);
        },
        routes: [
          // Files Tab
          GoRoute(
            path: '/files',
            name: 'project-files',
            builder: (context, state) {
              final projectPath = state.pathParameters['projectPath']!;
              return FilesScreen(projectPath: projectPath);
            },
          ),
          
          // File Viewer
          GoRoute(
            path: '/files/:filePath',
            name: 'file-viewer',
            builder: (context, state) {
              final projectPath = state.pathParameters['projectPath']!;
              final filePath = state.pathParameters['filePath']!;
              return FileViewerScreen(
                projectPath: projectPath,
                filePath: filePath,
              );
            },
          ),
          
          // Prompts Tab
          GoRoute(
            path: '/prompts',
            name: 'project-prompts',
            builder: (context, state) {
              final projectPath = state.pathParameters['projectPath']!;
              return PromptsScreen(projectPath: projectPath);
            },
          ),
          
          // Prompt Editor
          GoRoute(
            path: '/prompts/new',
            name: 'prompt-editor',
            builder: (context, state) {
              final projectPath = state.pathParameters['projectPath']!;
              return PromptEditorScreen(projectPath: projectPath);
            },
          ),
          
          // Preview Tab
          GoRoute(
            path: '/preview',
            name: 'project-preview',
            builder: (context, state) {
              final projectPath = state.pathParameters['projectPath']!;
              return PreviewScreen(projectPath: projectPath);
            },
          ),
        ],
      ),
    ],
  );
}

class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getCurrentIndex(context),
        onTap: (index) => _onTap(context, index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_outlined),
            activeIcon: Icon(Icons.folder),
            label: 'Projects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline_outlined),
            activeIcon: Icon(Icons.timeline),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).location;
    if (location.startsWith('/dashboard')) return 0;
    if (location.startsWith('/activity')) return 1;
    if (location.startsWith('/settings')) return 2;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/dashboard');
        break;
      case 1:
        context.go('/activity');
        break;
      case 2:
        context.go('/settings');
        break;
    }
  }
}
