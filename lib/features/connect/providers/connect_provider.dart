import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'connect_provider.g.dart';

@riverpod
class ConnectProvider extends _$ConnectProvider {
  @override
  Future<ConnectionSettings> build() async {
    final prefs = await SharedPreferences.getInstance();
    
    return ConnectionSettings(
      serverUrl: prefs.getString('server_url') ?? 'http://192.168.1.42:3001',
      apiToken: prefs.getString('api_token') ?? '',
      autoReconnect: prefs.getBool('auto_reconnect') ?? false,
      isConnected: false,
    );
  }

  Future<void> saveConnectionSettings({
    required String serverUrl,
    required String apiToken,
    required bool autoReconnect,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.setString('server_url', serverUrl);
    await prefs.setString('api_token', apiToken);
    await prefs.setBool('auto_reconnect', autoReconnect);
    
    state = AsyncValue.data(
      ConnectionSettings(
        serverUrl: serverUrl,
        apiToken: apiToken,
        autoReconnect: autoReconnect,
        isConnected: true,
      ),
    );
  }

  Future<void> updateConnectionStatus(bool isConnected) async {
    final currentSettings = state.value;
    if (currentSettings != null) {
      state = AsyncValue.data(
        currentSettings.copyWith(isConnected: isConnected),
      );
    }
  }

  Future<void> clearConnectionSettings() async {
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.remove('server_url');
    await prefs.remove('api_token');
    await prefs.remove('auto_reconnect');
    
    state = const AsyncValue.data(
      ConnectionSettings(
        serverUrl: 'http://192.168.1.42:3001',
        apiToken: '',
        autoReconnect: false,
        isConnected: false,
      ),
    );
  }
}

class ConnectionSettings {
  final String serverUrl;
  final String apiToken;
  final bool autoReconnect;
  final bool isConnected;

  const ConnectionSettings({
    required this.serverUrl,
    required this.apiToken,
    required this.autoReconnect,
    required this.isConnected,
  });

  ConnectionSettings copyWith({
    String? serverUrl,
    String? apiToken,
    bool? autoReconnect,
    bool? isConnected,
  }) {
    return ConnectionSettings(
      serverUrl: serverUrl ?? this.serverUrl,
      apiToken: apiToken ?? this.apiToken,
      autoReconnect: autoReconnect ?? this.autoReconnect,
      isConnected: isConnected ?? this.isConnected,
    );
  }
}
