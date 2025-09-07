import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class ProjectTabs extends StatelessWidget {
  final TabController tabController;
  final int currentIndex;
  final ValueChanged<int> onTabChanged;

  const ProjectTabs({
    super.key,
    required this.tabController,
    required this.currentIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.secondaryBackground,
        border: const Border(
          bottom: BorderSide(
            color: AppTheme.border,
            width: 1,
          ),
        ),
      ),
      child: TabBar(
        controller: tabController,
        onTap: onTabChanged,
        indicatorColor: AppTheme.primaryAccent,
        indicatorWeight: 2,
        labelColor: AppTheme.primaryAccent,
        unselectedLabelColor: AppTheme.textTertiary,
        labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w400,
        ),
        tabs: const [
          Tab(text: 'Overview'),
          Tab(text: 'Files'),
          Tab(text: 'Prompts'),
          Tab(text: 'Activity'),
          Tab(text: 'Preview'),
        ],
      ),
    );
  }
}
