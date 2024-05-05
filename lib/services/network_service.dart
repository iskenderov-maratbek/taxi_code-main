import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkService extends ChangeNotifier {
  late StreamSubscription<ConnectivityResult> _streamNetwork;
  bool _networkStatus = true;
  bool get networkStatus => _networkStatus;

  NetworkService() {
    _streamNetwork = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        _updateConnectionStatus(result);
      },
    );
  }

  Future<void> checkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    _updateConnectionStatus(connectivityResult);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result != ConnectivityResult.wifi &&
        result != ConnectivityResult.mobile) {
      final response = await InternetAddress.lookup('example.com');
      if (response.isNotEmpty && response[0].rawAddress.isNotEmpty) {
        _networkStatus = true;
      }
    } else {
      _networkStatus = false;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _streamNetwork.cancel();
    super.dispose();
  }
}
