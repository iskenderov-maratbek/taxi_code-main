import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_code/network_status.dart';
import 'package:taxi_code/menu/menu.dart';
import 'package:taxi_code/services/misc_service.dart';
import 'package:taxi_code/my_location_button.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Completer<GoogleMapController> _mapController = Completer();
  late Marker start;
  late Marker end;
  // late final AnimationController _animationController;
  // late final Animation<double> _animation;
  late final MenuService menuService;
  bool menuClicked = false;
  late Set<Marker> markers;
  //Обновление карты
  void updateMapTheme(GoogleMapController controller) {
    getJsonFileFromThemes('map_themes/night_style.json')
        .then((newStyle) => setGoogleMapStyle(controller, newStyle));
  }

  //Получение информации из Json файла
  Future<String> getJsonFileFromThemes(String path) async {
    ByteData byteData = await rootBundle.load(path);
    return utf8.decode(byteData.buffer.asUint8List());
  }

  //Изменение стиля карты
  void setGoogleMapStyle(GoogleMapController controller, String newStyle) {
    controller.setMapStyle(newStyle);
  }

  //Инициализация карты
  Future<void> _onMapCreated(GoogleMapController controller) async {
    _mapController.complete(controller);
    updateMapTheme(await _mapController.future);
  }

  menuChange() {
    menuService.hideMenu();
  }

  setStartLocation(position) async {
    setState(() {
      start = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        consumeTapEvents: true,
        draggable: true,
        markerId: const MarkerId('start'),
        position: LatLng(position.latitude, position.longitude),
      );
      markers.add(start);
    });
    GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 18.0,
        ),
      ),
    );
  }

  setEndLocation(position) async {
    setState(() {
      start = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        consumeTapEvents: true,
        draggable: true,
        markerId: const MarkerId('start'),
        position: LatLng(position.latitude, position.longitude),
      );
      markers.add(start);
    });
    GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 18.0,
        ),
      ),
    );
  }

  @override
  void initState() {
    menuService = MenuService();
    markers = {};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (a) {
        menuChange();
      },
      child: Listener(
        onPointerDown: (PointerDownEvent event) {
          menuClicked ? menuClicked = false : menuChange();
        },
        child: SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                GoogleMap(
                  trafficEnabled: true,
                  compassEnabled: false,
                  zoomControlsEnabled: false,
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(42.87191396899088, 74.57358476987368),
                    zoom: 12.0,
                  ),
                  markers: markers,
                ),
                const Align(
                  alignment: Alignment.topCenter,
                  child: NetworkStatus(),
                ),
                Listener(
                  onPointerDown: (e) {
                    menuClicked = true;
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, right: 20),
                      child: Menu(menuService: menuService),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: MyLocationButton(setMyLocation: setStartLocation),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
