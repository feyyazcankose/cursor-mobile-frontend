import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/services/api_service.dart';
import '../../../core/services/websocket_service.dart';
import '../providers/connect_provider.dart';

class ConnectScreen extends ConsumerStatefulWidget {
  const ConnectScreen({super.key});

  @override
  ConsumerState<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends ConsumerState<ConnectScreen> {
  final _serverUrlController = TextEditingController(text: 'http://192.168.1.42:3001');
  final _apiTokenController = TextEditingController();
  bool _autoReconnect = false;
  bool _isConnecting = false;

  @override
  void dispose() {
    _serverUrlController.dispose();
    _apiTokenController.dispose();
    super.dispose();
  }

  Future<void> _connect() async {
    if (_isConnecting) return;

    setState(() {
      _isConnecting = true;
    });

    try {
      final serverUrl = _serverUrlController.text.trim();
      final apiToken = _apiTokenController.text.trim();

      if (serverUrl.isEmpty) {
        _showError('Please enter a server URL');
        return;
      }

      // Update API service configuration
      ref.read(apiServiceProvider.notifier).updateBaseUrl(serverUrl);
      ref.read(apiServiceProvider.notifier).setApiKey(apiToken.isEmpty ? null : apiToken);

      // Test connection
      final isConnected = await ref.read(apiServiceProvider.notifier).checkConnection();
      
      if (!isConnected) {
        _showError('Failed to connect to server. Please check the URL and try again.');
        return;
      }

      // Connect WebSocket
      await ref.read(webSocketServiceProvider.notifier).connect(serverUrl, apiKey: apiToken.isEmpty ? null : apiToken);

      // Save connection settings
      await ref.read(connectProvider.notifier).saveConnectionSettings(
        serverUrl: serverUrl,
        apiToken: apiToken,
        autoReconnect: _autoReconnect,
      );

      // Navigate to dashboard
      if (mounted) {
        context.go('/dashboard');
      }
    } catch (e) {
      _showError('Connection failed: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() {
          _isConnecting = false;
        });
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusM),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingXXL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              
              // Logo/Title
              Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryAccent,
                      borderRadius: BorderRadius.circular(AppTheme.radiusXL),
                      boxShadow: AppTheme.shadowL,
                    ),
                    child: const Icon(
                      Icons.code,
                      size: 40,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingXL),
                  Text(
                    'Cursor Mobile',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingS),
                  Text(
                    'Connect to your development machine',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              
              const SizedBox(height: AppTheme.spacingXXXL),
              
              // Connection Form
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Server URL
                  Text(
                    'Server URL',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingS),
                  TextField(
                    controller: _serverUrlController,
                    decoration: const InputDecoration(
                      hintText: 'http://192.168.1.42:3001',
                      prefixIcon: Icon(Icons.link, color: AppTheme.textTertiary),
                    ),
                    keyboardType: TextInputType.url,
                    enabled: !_isConnecting,
                  ),
                  
                  const SizedBox(height: AppTheme.spacingXL),
                  
                  // API Token
                  Text(
                    'API Token (optional)',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingS),
                  TextField(
                    controller: _apiTokenController,
                    decoration: const InputDecoration(
                      hintText: 'API Token (optional)',
                      prefixIcon: Icon(Icons.key, color: AppTheme.textTertiary),
                    ),
                    obscureText: true,
                    enabled: !_isConnecting,
                  ),
                  
                  const SizedBox(height: AppTheme.spacingXL),
                  
                  // Auto-reconnect toggle
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Auto-reconnect',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      ),
                      Switch(
                        value: _autoReconnect,
                        onChanged: _isConnecting ? null : (value) {
                          setState(() {
                            _autoReconnect = value;
                          });
                        },
                        activeColor: AppTheme.primaryAccent,
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: AppTheme.spacingXXXL),
              
              // Connect Button
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: _isConnecting ? null : _connect,
                  child: _isConnecting
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.textPrimary),
                          ),
                        )
                      : const Text('Connect'),
                ),
              ),
              
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
