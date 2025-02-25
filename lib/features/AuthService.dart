import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:get_it/get_it.dart';

class AuthService {
  String? _token;

  void setToken(String token) {
    _token = token;
  }

  String? get token => _token;
}

// Register GetIt instance

void setup() {
  getIt.registerSingleton<AuthService>(AuthService());
}
