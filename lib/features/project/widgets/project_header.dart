import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/models/project.dart';

class ProjectHeader extends StatelessWidget {
  final Project project;
  final VoidCallback? onBack;
  final VoidCallback? onOpenInCursor;
  final VoidCallback? onRunPreview;

  const ProjectHeader({
    super.key,
    required this.project,
    this.onBack,
    this.onOpenInCursor,
    this.onRunPreview,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: BoxDecoration(
        color: AppTheme.secondaryBackground,
        border: const Border(
          bottom: BorderSide(
            color: AppTheme.border,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Top Row
          Row(
            children: [
              // Back Button
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: onBack,
                color: AppTheme.textPrimary,
              ),
              
              // Project Name
              Expanded(
                child: Text(
                  project.name,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              
              // More Options
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  _showMoreOptions(context);
                },
                color: AppTheme.textPrimary,
              ),
            ],
          ),
          
          const SizedBox(height: AppTheme.spacingL),
          
          // Status Chips
          Wrap(
            spacing: AppTheme.spacingS,
            runSpacing: AppTheme.spacingS,
            alignment: WrapAlignment.center,
            children: [
              _buildStatusChip('Running', AppTheme.success),
              _buildStatusChip('Branch: ${project.gitBranch ?? 'main'}', AppTheme.info),
              _buildStatusChip('Last commit 5m ago', AppTheme.textTertiary),
            ],
          ),
          
          const SizedBox(height: AppTheme.spacingXL),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onOpenInCursor,
                  icon: const Icon(Icons.open_in_new, size: 18),
                  label: const Text('Open in Cursor'),
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onRunPreview,
                  icon: const Icon(Icons.play_arrow, size: 18),
                  label: const Text('Run Preview'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String label, Color color) {
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
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.secondaryBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTheme.radiusL),
        ),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppTheme.spacingL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppTheme.spacingL),
            
            // Options
            _buildOption(
              context,
              icon: Icons.refresh,
              title: 'Refresh Project',
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement refresh
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Refresh functionality coming soon'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
            _buildOption(
              context,
              icon: Icons.settings,
              title: 'Project Settings',
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to settings
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Project settings coming soon'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
            _buildOption(
              context,
              icon: Icons.archive,
              title: 'Archive Project',
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement archive
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Archive functionality coming soon'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radiusM),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingM,
          vertical: AppTheme.spacingL,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppTheme.textSecondary,
              size: 20,
            ),
            const SizedBox(width: AppTheme.spacingM),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.textPrimary,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.textTertiary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
