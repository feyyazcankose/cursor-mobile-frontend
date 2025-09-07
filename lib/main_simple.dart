import 'package:flutter/material.dart';

void main() {
  runApp(const CursorMobileApp());
}

class CursorMobileApp extends StatelessWidget {
  const CursorMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cursor Mobile',
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF7C5CFF),
        scaffoldBackgroundColor: const Color(0xFF0B0C10),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0B0C10),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF1A1B23),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF7C5CFF),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      home: const ConnectScreen(),
    );
  }
}

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key});

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
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

    // Simulate connection
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isConnecting = false;
    });

    // Navigate to dashboard
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0C10),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
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
                      color: const Color(0xFF7C5CFF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.code,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Cursor Mobile',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Connect to your development machine',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFB8BCC8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              
              const SizedBox(height: 48),
              
              // Connection Form
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Server URL',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _serverUrlController,
                    decoration: const InputDecoration(
                      hintText: 'http://192.168.1.42:3001',
                      prefixIcon: Icon(Icons.link, color: Color(0xFF8B8F9A)),
                      filled: true,
                      fillColor: Color(0xFF2A2D3A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    keyboardType: TextInputType.url,
                    enabled: !_isConnecting,
                  ),
                  
                  const SizedBox(height: 20),
                  
                  const Text(
                    'API Token (optional)',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _apiTokenController,
                    decoration: const InputDecoration(
                      hintText: 'API Token (optional)',
                      prefixIcon: Icon(Icons.key, color: Color(0xFF8B8F9A)),
                      filled: true,
                      fillColor: Color(0xFF2A2D3A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    obscureText: true,
                    enabled: !_isConnecting,
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Auto-reconnect toggle
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Auto-reconnect',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
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
                        activeColor: const Color(0xFF7C5CFF),
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 48),
              
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
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0C10),
      appBar: AppBar(
        title: const Text('Projects'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.circle, color: Color(0xFF00D4AA), size: 8),
                SizedBox(width: 4),
                Text('Connected', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Add project functionality coming soon'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Search Bar
          TextField(
            decoration: const InputDecoration(
              hintText: 'Search projects, files...',
              prefixIcon: Icon(Icons.search, color: Color(0xFF8B8F9A)),
              filled: true,
              fillColor: Color(0xFF2A2D3A),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Project Cards
          _buildProjectCard(
            context,
            'Project Alpha',
            'A Flutter mobile application for task management',
            '12 min ago',
            'main',
            'dart',
            'flutter',
            true,
          ),
          _buildProjectCard(
            context,
            'Project Beta',
            'React web application with TypeScript',
            '30 min ago',
            'develop',
            'typescript',
            'react',
            false,
          ),
          _buildProjectCard(
            context,
            'Project Gamma',
            'Node.js backend API service',
            '1 hr ago',
            'main',
            'javascript',
            'nodejs',
            true,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1A1B23),
        selectedItemColor: const Color(0xFF7C5CFF),
        unselectedItemColor: const Color(0xFF8B8F9A),
        type: BottomNavigationBarType.fixed,
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

  Widget _buildProjectCard(
    BuildContext context,
    String name,
    String description,
    String lastModified,
    String branch,
    String language,
    String framework,
    bool isRunning,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProjectDetailScreen()),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                      color: _getProjectColor(language),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getProjectIcon(language),
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  // Project Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFFB8BCC8),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
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
                          color: isRunning ? const Color(0xFF00D4AA) : const Color(0xFF8B8F9A),
                          shape: BoxShape.circle,
                        ),
                      ),
                      
                      const SizedBox(width: 12),
                      
                      // Menu Button
                      IconButton(
                        icon: const Icon(
                          Icons.more_vert,
                          color: Color(0xFF8B8F9A),
                          size: 20,
                        ),
                        onPressed: () {},
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
              
              const SizedBox(height: 12),
              
              // Project Details
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildChip(language, Icons.code, _getLanguageColor(language)),
                  _buildChip(framework, Icons.extension, const Color(0xFF4DABF7)),
                  _buildChip(branch, Icons.account_tree, const Color(0xFFFFB800)),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Footer
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 14,
                    color: Color(0xFF8B8F9A),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    lastModified,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF8B8F9A),
                    ),
                  ),
                  const Spacer(),
                  if (!isRunning)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFB800).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: const Color(0xFFFFB800).withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: const Text(
                        'Modified',
                        style: TextStyle(
                          color: Color(0xFFFFB800),
                          fontSize: 10,
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

  Widget _buildChip(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
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
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Color _getProjectColor(String language) {
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
      default:
        return const Color(0xFF7C5CFF);
    }
  }

  IconData _getProjectIcon(String language) {
    switch (language.toLowerCase()) {
      case 'dart':
      case 'flutter':
        return Icons.flutter_dash;
      case 'javascript':
      case 'typescript':
        return Icons.javascript;
      case 'python':
        return Icons.code;
      case 'java':
        return Icons.coffee;
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
      default:
        return const Color(0xFF7C5CFF);
    }
  }
}

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0C10),
      appBar: AppBar(
        title: const Text('Project Alpha'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.folder_outlined,
              size: 80,
              color: Color(0xFF8B8F9A),
            ),
            SizedBox(height: 20),
            Text(
              'Project Detail',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Coming soon...',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFFB8BCC8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
