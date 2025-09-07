import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/models/project.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback? onTap;
  final VoidCallback? onMenuTap;

  const ProjectCard({
    super.key,
    required this.project,
    this.onTap,
    this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  // Project Icon
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _getProjectColor(project.language),
                      borderRadius: BorderRadius.circular(AppTheme.radiusM),
                    ),
                    child: Icon(
                      _getProjectIcon(project.language),
                      color: AppTheme.textPrimary,
                      size: 20,
                    ),
                  ),
                  
                  const SizedBox(width: AppTheme.spacingM),
                  
                  // Project Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.name,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppTheme.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (project.description != null) ...[
                          const SizedBox(height: AppTheme.spacingXS),
                          Text(
                            project.description!,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  
                  // Status & Menu
                  Row(
                    children: [
                      // Status Dot
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: project.isRunning ? AppTheme.success : AppTheme.textTertiary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      
                      const SizedBox(width: AppTheme.spacingM),
                      
                      // Menu Button
                      IconButton(
                        icon: const Icon(
                          Icons.more_vert,
                          color: AppTheme.textTertiary,
                          size: 20,
                        ),
                        onPressed: onMenuTap,
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: AppTheme.spacingM),
              
              // Project Details
              Wrap(
                spacing: AppTheme.spacingS,
                runSpacing: AppTheme.spacingXS,
                children: [
                  if (project.language != null)
                    _buildChip(
                      context,
                      project.language!,
                      Icons.code,
                      _getLanguageColor(project.language!),
                    ),
                  
                  if (project.framework != null)
                    _buildChip(
                      context,
                      project.framework!,
                      Icons.extension,
                      AppTheme.info,
                    ),
                  
                  if (project.gitBranch != null)
                    _buildChip(
                      context,
                      '${project.gitBranch}',
                      Icons.git_branch,
                      AppTheme.warning,
                    ),
                  
                  if (project.fileCount != null)
                    _buildChip(
                      context,
                      '${project.fileCount} files',
                      Icons.description,
                      AppTheme.textTertiary,
                    ),
                ],
              ),
              
              const SizedBox(height: AppTheme.spacingM),
              
              // Footer
              Row(
                children: [
                  // Last Modified
                  if (project.lastModified != null) ...[
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: AppTheme.textTertiary,
                    ),
                    const SizedBox(width: AppTheme.spacingXS),
                    Text(
                      _formatLastModified(project.lastModified!),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textTertiary,
                      ),
                    ),
                  ],
                  
                  const Spacer(),
                  
                  // Git Status
                  if (project.hasUncommittedChanges)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingS,
                        vertical: AppTheme.spacingXS,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.warning.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppTheme.radiusS),
                        border: Border.all(
                          color: AppTheme.warning.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'Modified',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.warning,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingS,
        vertical: AppTheme.spacingXS,
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
            size: 12,
            color: color,
          ),
          const SizedBox(width: AppTheme.spacingXS),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Color _getProjectColor(String? language) {
    switch (language?.toLowerCase()) {
      case 'dart':
      case 'flutter':
        return const Color(0xFF00D4AA);
      case 'javascript':
      case 'typescript':
        return const Color(0xFFF7DF1E);
      case 'python':
        return const Color(0xFF3776AB);
      case 'java':
        return const Color(0xFFED8B00);
      case 'csharp':
        return const Color(0xFF239120);
      case 'cpp':
      case 'c':
        return const Color(0xFF00599C);
      case 'rust':
        return const Color(0xFF000000);
      case 'go':
        return const Color(0xFF00ADD8);
      case 'php':
        return const Color(0xFF777BB4);
      case 'ruby':
        return const Color(0xFFCC342D);
      case 'swift':
        return const Color(0xFFFA7343);
      case 'kotlin':
        return const Color(0xFF7F52FF);
      default:
        return AppTheme.primaryAccent;
    }
  }

  IconData _getProjectIcon(String? language) {
    switch (language?.toLowerCase()) {
      case 'dart':
      case 'flutter':
        return Icons.flutter_dash;
      case 'javascript':
      case 'typescript':
        return Icons.javascript;
      case 'python':
        return Icons.python;
      case 'java':
        return Icons.coffee;
      case 'csharp':
        return Icons.code;
      case 'cpp':
      case 'c':
        return Icons.memory;
      case 'rust':
        return Icons.construction;
      case 'go':
        return Icons.golf_course;
      case 'php':
        return Icons.php;
      case 'ruby':
        return Icons.diamond;
      case 'swift':
        return Icons.speed;
      case 'kotlin':
        return Icons.android;
      default:
        return Icons.folder;
    }
  }

  Color _getLanguageColor(String language) {
    switch (language.toLowerCase()) {
      case 'dart':
      case 'flutter':
        return const Color(0xFF00D4AA);
      case 'javascript':
      case 'typescript':
        return const Color(0xFFF7DF1E);
      case 'python':
        return const Color(0xFF3776AB);
      case 'java':
        return const Color(0xFFED8B00);
      case 'csharp':
        return const Color(0xFF239120);
      case 'cpp':
      case 'c':
        return const Color(0xFF00599C);
      case 'rust':
        return const Color(0xFF000000);
      case 'go':
        return const Color(0xFF00ADD8);
      case 'php':
        return const Color(0xFF777BB4);
      case 'ruby':
        return const Color(0xFFCC342D);
      case 'swift':
        return const Color(0xFFFA7343);
      case 'kotlin':
        return const Color(0xFF7F52FF);
      default:
        return AppTheme.primaryAccent;
    }
  }

  String _formatLastModified(String lastModified) {
    try {
      final date = DateTime.parse(lastModified);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 0) {
        return '${difference.inDays}d ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours}h ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes}m ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return 'Unknown';
    }
  }
}
