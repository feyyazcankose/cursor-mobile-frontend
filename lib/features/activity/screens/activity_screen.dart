import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';

class ActivityScreen extends ConsumerStatefulWidget {
  const ActivityScreen({super.key});

  @override
  ConsumerState<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends ConsumerState<ActivityScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      appBar: AppBar(
        title: const Text('Activity'),
        backgroundColor: AppTheme.primaryBackground,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Settings
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Activity settings coming soon'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.primaryAccent,
          labelColor: AppTheme.primaryAccent,
          unselectedLabelColor: AppTheme.textTertiary,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Prompts'),
            Tab(text: 'Files'),
            Tab(text: 'Server'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildActivityList('All'),
          _buildActivityList('Prompts'),
          _buildActivityList('Files'),
          _buildActivityList('Server'),
        ],
      ),
    );
  }

  Widget _buildActivityList(String filter) {
    final activities = _getMockActivities(filter);

    return ListView.builder(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        return Container(
          margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
          padding: const EdgeInsets.all(AppTheme.spacingL),
          decoration: BoxDecoration(
            color: AppTheme.secondaryBackground,
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
            border: Border.all(color: AppTheme.border),
          ),
          child: Row(
            children: [
              // Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: activity['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusM),
                ),
                child: Icon(
                  activity['icon'],
                  color: activity['color'],
                  size: 20,
                ),
              ),
              
              const SizedBox(width: AppTheme.spacingM),
              
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity['title'],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXS),
                    Text(
                      'Project: ${activity['project']}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXS),
                    Text(
                      activity['time'],
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Status
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingS,
                  vertical: AppTheme.spacingXS,
                ),
                decoration: BoxDecoration(
                  color: activity['statusColor'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusS),
                ),
                child: Text(
                  activity['status'],
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: activity['statusColor'],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Map<String, dynamic>> _getMockActivities(String filter) {
    final allActivities = [
      {
        'icon': Icons.edit,
        'title': 'Prompt: Refactor code',
        'project': 'Codebase',
        'time': '10:30 AM',
        'status': 'Completed',
        'statusColor': AppTheme.success,
        'color': AppTheme.primaryAccent,
        'type': 'prompt',
      },
      {
        'icon': Icons.description,
        'title': 'File: index.html',
        'project': 'Website',
        'time': '11:15 AM',
        'status': 'Modified',
        'statusColor': AppTheme.warning,
        'color': AppTheme.info,
        'type': 'file',
      },
      {
        'icon': Icons.dns,
        'title': 'Server: Started',
        'project': 'API',
        'time': '12:00 PM',
        'status': 'Running',
        'statusColor': AppTheme.success,
        'color': AppTheme.success,
        'type': 'server',
      },
      {
        'icon': Icons.edit,
        'title': 'Prompt: Add feature',
        'project': 'Mobile App',
        'time': '9:45 AM',
        'status': 'Running',
        'statusColor': AppTheme.info,
        'color': AppTheme.primaryAccent,
        'type': 'prompt',
      },
      {
        'icon': Icons.description,
        'title': 'File: README.md',
        'project': 'Documentation',
        'time': '10:30 AM',
        'status': 'Completed',
        'statusColor': AppTheme.success,
        'color': AppTheme.info,
        'type': 'file',
      },
      {
        'icon': Icons.dns,
        'title': 'Server: Stopped',
        'project': 'Backend',
        'time': '11:00 AM',
        'status': 'Stopped',
        'statusColor': AppTheme.error,
        'color': AppTheme.error,
        'type': 'server',
      },
    ];

    if (filter == 'All') return allActivities;
    
    return allActivities.where((activity) {
      return activity['type'].toLowerCase() == filter.toLowerCase();
    }).toList();
  }
}
