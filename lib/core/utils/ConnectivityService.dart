import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  ConnectivityService() {}

  Future<bool> _hasInternetAccess() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }

  Future<bool> checkCurrentStatus() async {
    final results = await _connectivity.checkConnectivity();
    final isNetworkAvailable = results.any((r) => r != ConnectivityResult.none);
    final hasInternet = isNetworkAvailable && await _hasInternetAccess();
    return hasInternet;
  }
}
