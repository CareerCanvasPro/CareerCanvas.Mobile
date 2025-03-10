import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  String? _token;

  String? get token => _token;

  Future<void> setToken(String token) async {
    _token = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('auth_token');
  }

  Future<void> clearToken() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
}

// Register GetIt instance

void setup() {
  getIt.registerSingleton<AuthService>(AuthService());
}
