import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/models/project.dart';
import '../providers/project_provider.dart';
import '../widgets/project_header.dart';
import '../widgets/project_tabs.dart';

class ProjectDetailScreen extends ConsumerStatefulWidget {
  final String projectPath;

  const ProjectDetailScreen({
    super.key,
    required this.projectPath,
  });

  @override
  ConsumerState<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends ConsumerState<ProjectDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projectAsync = ref.watch(projectProvider(widget.projectPath));

    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      body: projectAsync.when(
        data: (project) => Column(
          children: [
            // Project Header
            ProjectHeader(
              project: project,
              onBack: () => context.go('/dashboard'),
              onOpenInCursor: () {
                // TODO: Implement open in Cursor
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Open in Cursor functionality coming soon'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              onRunPreview: () {
                // TODO: Implement run preview
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Run preview functionality coming soon'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),

            // Tabs
            ProjectTabs(
              tabController: _tabController,
              currentIndex: _currentTabIndex,
              onTabChanged: (index) {
                setState(() {
                  _currentTabIndex = index;
                });
                _tabController.animateTo(index);
              },
            ),

            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildOverviewTab(project),
                  _buildFilesTab(),
                  _buildPromptsTab(),
                  _buildActivityTab(),
                  _buildPreviewTab(),
                ],
              ),
            ),
          ],
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryAccent),
          ),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: AppTheme.error,
              ),
              const SizedBox(height: AppTheme.spacingL),
              Text(
                'Failed to load project',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: AppTheme.spacingS),
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.spacingXL),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(projectProvider(widget.projectPath));
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewTab(Project project) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Chips
          Wrap(
            spacing: AppTheme.spacingS,
            runSpacing: AppTheme.spacingS,
            children: [
              _buildStatusChip('Running', AppTheme.success, Icons.play_arrow),
              if (project.gitBranch != null)
                _buildStatusChip(
                  'Branch: ${project.gitBranch}',
                  AppTheme.info,
                  Icons.git_branch,
                ),
              _buildStatusChip(
                'Last commit 5m ago',
                AppTheme.textTertiary,
                Icons.access_time,
              ),
            ],
          ),

          const SizedBox(height: AppTheme.spacingXXL),

          // Recent Activity
          Text(
            'Activity',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: AppTheme.spacingL),
          _buildActivityList(),

          const SizedBox(height: AppTheme.spacingXXL),

          // Quick Actions
          Text(
            'Quick actions',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: AppTheme.spacingL),
          _buildQuickActions(),

          const SizedBox(height: AppTheme.spacingXXL),

          // Files Summary
          Text(
            'Files summary',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: AppTheme.spacingL),
          _buildFilesSummary(),
        ],
      ),
    );
  }

  Widget _buildFilesTab() {
    return const Center(
      child: Text('Files tab - Coming soon'),
    );
  }

  Widget _buildPromptsTab() {
    return const Center(
      child: Text('Prompts tab - Coming soon'),
    );
  }

  Widget _buildActivityTab() {
    return const Center(
      child: Text('Activity tab - Coming soon'),
    );
  }

  Widget _buildPreviewTab() {
    return const Center(
      child: Text('Preview tab - Coming soon'),
    );
  }

  Widget _buildStatusChip(String label, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingM,
        vertical: AppTheme.spacingS,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusS),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          const SizedBox(width: AppTheme.spacingXS),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityList() {
    final activities = [
      {'message': 'Fix bug in user authentication', 'time': '5m ago'},
      {'message': 'Update documentation for API', 'time': '15m ago'},
      {'message': 'Add new feature for user profiles', 'time': '30m ago'},
      {'message': 'Refactor code for improved performance', 'time': '1h ago'},
      {'message': 'Initial project setup', 'time': '2h ago'},
    ];

    return Column(
      children: activities.map((activity) {
        return Container(
          margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
          padding: const EdgeInsets.all(AppTheme.spacingL),
          decoration: BoxDecoration(
            color: AppTheme.secondaryBackground,
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
            border: Border.all(
              color: AppTheme.border,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppTheme.primaryAccent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Commit: ${activity['message']}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXS),
                    Text(
                      activity['time']!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      {'icon': Icons.description, 'label': 'Files', 'color': AppTheme.info},
      {'icon': Icons.edit, 'label': 'Prompt', 'color': AppTheme.primaryAccent},
      {'icon': Icons.preview, 'label': 'Preview', 'color': AppTheme.success},
      {'icon': Icons.settings, 'label': 'Settings', 'color': AppTheme.warning},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: AppTheme.spacingM,
        mainAxisSpacing: AppTheme.spacingM,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final action = actions[index];
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.secondaryBackground,
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
            border: Border.all(
              color: AppTheme.border,
              width: 1,
            ),
          ),
          child: InkWell(
            onTap: () {
              // TODO: Implement action
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${action['label']} action coming soon'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  action['icon'] as IconData,
                  color: action['color'] as Color,
                  size: 32,
                ),
                const SizedBox(height: AppTheme.spacingS),
                Text(
                  action['label'] as String,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilesSummary() {
    final files = [
      {'name': 'UserList.js', 'path': 'src/components/UserList.js', 'size': '12KB'},
      {'name': 'api.js', 'path': 'src/utils/api.js', 'size': '8KB'},
      {'name': 'App.js', 'path': 'src/App.js', 'size': '6KB'},
    ];

    return Column(
      children: files.map((file) {
        return Container(
          margin: const EdgeInsets.only(bottom: AppTheme.spacingS),
          padding: const EdgeInsets.all(AppTheme.spacingM),
          decoration: BoxDecoration(
            color: AppTheme.secondaryBackground,
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
            border: Border.all(
              color: AppTheme.border,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.description,
                color: AppTheme.textTertiary,
                size: 20,
              ),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      file['name']!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    Text(
                      file['path']!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                file['size']!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textTertiary,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
