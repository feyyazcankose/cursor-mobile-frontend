import '../models/project.dart';
import '../models/file.dart';
import '../models/cursor.dart';
import '../models/activity.dart';

class MockData {
  static List<Project> get mockProjects => [
    Project(
      name: 'Project Alpha',
      path: '/Users/developer/projects/alpha',
      description: 'A Flutter mobile application for task management',
      lastModified: DateTime.now().subtract(const Duration(minutes: 12)).toIso8601String(),
      fileCount: 45,
      gitBranch: 'main',
      gitStatus: 'clean',
      language: 'dart',
      framework: 'flutter',
    ),
    Project(
      name: 'Project Beta',
      path: '/Users/developer/projects/beta',
      description: 'React web application with TypeScript',
      lastModified: DateTime.now().subtract(const Duration(minutes: 30)).toIso8601String(),
      fileCount: 78,
      gitBranch: 'develop',
      gitStatus: 'modified',
      language: 'typescript',
      framework: 'react',
    ),
    Project(
      name: 'Project Gamma',
      path: '/Users/developer/projects/gamma',
      description: 'Node.js backend API service',
      lastModified: DateTime.now().subtract(const Duration(hours: 1)).toIso8601String(),
      fileCount: 32,
      gitBranch: 'main',
      gitStatus: 'clean',
      language: 'javascript',
      framework: 'nodejs',
    ),
    Project(
      name: 'Project Delta',
      path: '/Users/developer/projects/delta',
      description: 'Python data analysis project',
      lastModified: DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
      fileCount: 23,
      gitBranch: 'feature/ml-models',
      gitStatus: 'staged',
      language: 'python',
      framework: 'pandas',
    ),
    Project(
      name: 'Project Epsilon',
      path: '/Users/developer/projects/epsilon',
      description: 'Go microservice for user authentication',
      lastModified: DateTime.now().subtract(const Duration(hours: 3)).toIso8601String(),
      fileCount: 15,
      gitBranch: 'main',
      gitStatus: 'clean',
      language: 'go',
      framework: 'gin',
    ),
  ];

  static List<FileItem> get mockFiles => [
    FileItem(
      name: 'main.dart',
      path: '/Users/developer/projects/alpha/lib/main.dart',
      relativePath: 'lib/main.dart',
      content: '''
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
''',
      type: 'dart',
      size: 1234,
      lastModified: DateTime.now().subtract(const Duration(minutes: 5)).toIso8601String(),
      isDirectory: false,
      language: 'dart',
    ),
    FileItem(
      name: 'pubspec.yaml',
      path: '/Users/developer/projects/alpha/pubspec.yaml',
      relativePath: 'pubspec.yaml',
      content: '''
name: alpha
description: A Flutter mobile application for task management.

publish_to: 'none'

version: 1.0.0+1

environment:
  sdk: '>=2.17.0 <3.0.0'

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0

flutter:
  uses-material-design: true
''',
      type: 'yaml',
      size: 456,
      lastModified: DateTime.now().subtract(const Duration(minutes: 10)).toIso8601String(),
      isDirectory: false,
      language: 'yaml',
    ),
    FileItem(
      name: 'lib',
      path: '/Users/developer/projects/alpha/lib',
      relativePath: 'lib',
      type: 'directory',
      size: 0,
      lastModified: DateTime.now().subtract(const Duration(minutes: 15)).toIso8601String(),
      isDirectory: true,
    ),
    FileItem(
      name: 'src',
      path: '/Users/developer/projects/alpha/src',
      relativePath: 'src',
      type: 'directory',
      size: 0,
      lastModified: DateTime.now().subtract(const Duration(minutes: 20)).toIso8601String(),
      isDirectory: true,
    ),
  ];

  static List<CursorResponse> get mockCursorResponses => [
    CursorResponse(
      id: '1',
      status: CursorStatus.completed,
      result: 'Successfully refactored the authentication module. The code is now more modular and maintainable.',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)).toIso8601String(),
      duration: 120,
    ),
    CursorResponse(
      id: '2',
      status: CursorStatus.running,
      result: 'Processing your request...',
      timestamp: DateTime.now().subtract(const Duration(minutes: 2)).toIso8601String(),
      duration: 45,
    ),
    CursorResponse(
      id: '3',
      status: CursorStatus.error,
      error: 'Failed to process the request. Please check your input and try again.',
      timestamp: DateTime.now().subtract(const Duration(minutes: 10)).toIso8601String(),
      duration: 30,
    ),
    CursorResponse(
      id: '4',
      status: CursorStatus.completed,
      result: 'Added comprehensive unit tests for the user service. Coverage increased to 95%.',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)).toIso8601String(),
      duration: 300,
    ),
  ];

  static List<ActivityItem> get mockActivities => [
    ActivityItem(
      id: '1',
      type: ActivityType.prompt,
      title: 'Refactor code for improved performance',
      description: 'Optimized database queries and improved caching',
      projectPath: '/Users/developer/projects/alpha',
      projectName: 'Project Alpha',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)).toIso8601String(),
      status: ActivityStatus.completed,
      metadata: {
        'duration': 120,
        'files_changed': 3,
      },
    ),
    ActivityItem(
      id: '2',
      type: ActivityType.file,
      title: 'Modified main.dart',
      description: 'Updated authentication logic',
      projectPath: '/Users/developer/projects/alpha',
      projectName: 'Project Alpha',
      timestamp: DateTime.now().subtract(const Duration(minutes: 15)).toIso8601String(),
      status: ActivityStatus.completed,
      metadata: {
        'file_path': 'lib/main.dart',
        'lines_added': 12,
        'lines_removed': 8,
      },
    ),
    ActivityItem(
      id: '3',
      type: ActivityType.server,
      title: 'Dev server started',
      description: 'Development server running on port 3000',
      projectPath: '/Users/developer/projects/beta',
      projectName: 'Project Beta',
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)).toIso8601String(),
      status: ActivityStatus.completed,
      metadata: {
        'port': 3000,
        'url': 'http://localhost:3000',
      },
    ),
    ActivityItem(
      id: '4',
      type: ActivityType.git,
      title: 'Committed changes',
      description: 'feat: add user authentication module',
      projectPath: '/Users/developer/projects/gamma',
      projectName: 'Project Gamma',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)).toIso8601String(),
      status: ActivityStatus.completed,
      metadata: {
        'commit_hash': 'a1b2c3d4',
        'files_changed': 5,
      },
    ),
    ActivityItem(
      id: '5',
      type: ActivityType.prompt,
      title: 'Add unit tests for the new feature',
      description: 'Generate comprehensive test coverage',
      projectPath: '/Users/developer/projects/delta',
      projectName: 'Project Delta',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
      status: ActivityStatus.running,
      metadata: {
        'duration': 180,
        'progress': 65,
      },
    ),
  ];

  static List<ActivityGroup> get mockActivityGroups => [
    ActivityGroup(
      date: 'Today',
      items: mockActivities.where((activity) {
        final activityDate = DateTime.parse(activity.timestamp);
        final today = DateTime.now();
        return activityDate.day == today.day &&
               activityDate.month == today.month &&
               activityDate.year == today.year;
      }).toList(),
    ),
    ActivityGroup(
      date: 'Yesterday',
      items: mockActivities.where((activity) {
        final activityDate = DateTime.parse(activity.timestamp);
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        return activityDate.day == yesterday.day &&
               activityDate.month == yesterday.month &&
               activityDate.year == yesterday.year;
      }).toList(),
    ),
  ];
}
