import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  late final StreamSubscription<List<ConnectivityResult>> _subscription;
  final StreamController<bool> _connectivityStreamController =
      StreamController<bool>.broadcast();

  ConnectivityService() {
    _startMonitoring();
  }

  Stream<bool> get connectivityStream => _connectivityStreamController.stream;

  void _startMonitoring() {
    _subscription = _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) async {
      final isNetworkAvailable =
          results.any((r) => r != ConnectivityResult.none);
      final hasInternet = isNetworkAvailable && await _hasInternetAccess();
      _connectivityStreamController.add(hasInternet);
    });

    _checkInitialConnection();
  }

  Future<void> _checkInitialConnection() async {
    final results = await _connectivity.checkConnectivity();
    final isNetworkAvailable = results.any((r) => r != ConnectivityResult.none);
    final hasInternet = isNetworkAvailable && await _hasInternetAccess();
    _connectivityStreamController.add(hasInternet);
  }

  Future<bool> _hasInternetAccess() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }

  void dispose() {
    _subscription.cancel();
    _connectivityStreamController.close();
  }
}
