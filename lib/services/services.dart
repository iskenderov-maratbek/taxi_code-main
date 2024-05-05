import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:taxi_code/services/auth_service.dart';
import 'package:taxi_code/services/network_service.dart';

class Services extends ChangeNotifier {
  late final AuthService authProvider;
  late final NetworkService networkService;
  bool networkStatus = true;

  late final StreamSubscription<ConnectivityResult> _streamNetwork;
  Services({required this.authProvider}) {
    _streamNetwork = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        networkStatus = result == ConnectivityResult.mobile ||
            result == ConnectivityResult.wifi;
      },
    );
  }

  void networkStatusListener() {
    _streamNetwork = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        networkStatus = result == ConnectivityResult.mobile ||
            result == ConnectivityResult.wifi;
      },
    );
    notifyListeners();
  }

  void streamDispose() {
    _streamNetwork.cancel();
  }
  // _streamPosition() {
  //   Geolocator.getPositionStream(
  //     locationSettings: const LocationSettings(
  //       accuracy: LocationAccuracy.high,
  //       distanceFilter: 10,
  //       timeLimit: Duration(seconds: 5),
  //     ),
  //   ).listen(
  //     (Position position) {
  //       position;
  //     },
  //     onError: (e) async {},
  //   );
  // }

  // offStreamNetwork() {
  //   print(_streamNetwork.isPaused);

  //   _streamNetwork.cancel();

  //   print(_streamNetwork.isPaused);

  // showPopUpOverlay(
  //   context: context,
  //   icon: Icons.wifi_off_rounded,
  //   text: 'Stream stopped',
  // );
}

  // switchStreamNetworkConnection() {
  //   _streamNetwork.pause();
  //   _streamNetwork.resume();
  // }
