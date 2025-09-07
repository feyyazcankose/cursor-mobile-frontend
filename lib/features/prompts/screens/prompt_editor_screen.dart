import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';

class PromptEditorScreen extends ConsumerStatefulWidget {
  final String projectPath;

  const PromptEditorScreen({
    super.key,
    required this.projectPath,
  });

  @override
  ConsumerState<PromptEditorScreen> createState() => _PromptEditorScreenState();
}

class _PromptEditorScreenState extends ConsumerState<PromptEditorScreen> {
  final _promptController = TextEditingController();

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      appBar: AppBar(
        title: const Text('New Prompt'),
        backgroundColor: AppTheme.primaryBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Prompt Input
            Text(
              'Prompt',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: AppTheme.spacingS),
            Expanded(
              child: TextField(
                controller: _promptController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  hintText: 'Enter your prompt here...',
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(
                  fontFamily: 'JetBrainsMono',
                  fontSize: 14,
                ),
              ),
            ),
            
            const SizedBox(height: AppTheme.spacingXL),
            
            // Context Section
            Text(
              'Context',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: AppTheme.spacingS),
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingL),
              decoration: BoxDecoration(
                color: AppTheme.secondaryBackground,
                borderRadius: BorderRadius.circular(AppTheme.radiusM),
                border: Border.all(color: AppTheme.border),
              ),
              child: const Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.description, color: AppTheme.textTertiary, size: 20),
                      SizedBox(width: AppTheme.spacingM),
                      Text('No context selected', style: TextStyle(color: AppTheme.textSecondary)),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, color: AppTheme.textTertiary, size: 16),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: AppTheme.spacingXL),
            
            // Advanced Section
            Text(
              'Advanced',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: AppTheme.spacingS),
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingL),
              decoration: BoxDecoration(
                color: AppTheme.secondaryBackground,
                borderRadius: BorderRadius.circular(AppTheme.radiusM),
                border: Border.all(color: AppTheme.border),
              ),
              child: const Column(
                children: [
                  Row(
                    children: [
                      Text('Parameters', style: TextStyle(color: AppTheme.textSecondary)),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, color: AppTheme.textTertiary, size: 16),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: AppTheme.spacingXXL),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => context.pop(),
                    child: const Text('Discard'),
                  ),
                ),
                const SizedBox(width: AppTheme.spacingM),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement run prompt
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Run prompt functionality coming soon'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: const Text('Run'),
                  ),
                ),
                const SizedBox(width: AppTheme.spacingM),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement run & open diff
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Run & open diff functionality coming soon'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: const Text('Run & Open Diff'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
