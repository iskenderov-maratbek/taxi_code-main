// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class LocationService {
//   late StreamSubscription<Position> _positionSubscription;
//   late LocationPermission _locationPermission;
//   late LatLng _currentPosition;
//   LatLng get currentPosition => _currentPosition;
//   late Position position;
//   late StreamSubscription<ServiceStatus> _serviceStatusSubscription;
//   bool _isLocationEnabled = false;
//   bool get isLocationEnabled => _isLocationEnabled;
//   LocationPermission get locationPermission => _locationPermission;

//   LocationService() {
//     print(
//         '===============================STARTING LOCATION SERVICE========================');
//     _positionSubscription = Geolocator.getPositionStream().listen(
//       (Position position) {
//         print('=======GET POS====================');
//         print(position);
//         _currentPosition = LatLng(position.latitude, position.longitude);
//         notifyListeners();
//       },
//       onError: (e) {
//         print('=======ERROR====================');
//         print(e.runtimeType);
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _positionSubscription.cancel();
//     // _serviceStatusSubscription.cancel();
//     super.dispose();
//   }

//   cancelListen() {
//     _positionSubscription.cancel();
//     notifyListeners();
//   }
// }
