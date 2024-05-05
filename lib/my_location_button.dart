import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taxi_code/autocomplete_form.dart';
import 'package:taxi_code/services/show_service_status.dart';

class MyLocationButton extends StatefulWidget {
  const MyLocationButton({super.key, required this.setMyLocation});

  @override
  State<MyLocationButton> createState() => _MyLocationButtonState();
  final Function setMyLocation;
}

class _MyLocationButtonState extends State<MyLocationButton> {
  late StreamSubscription<Position> _positionSubscription;
  late OverlayEntry overlayEntry;

  @override
  void dispose() {
    _positionSubscription.cancel();
    super.dispose();
  }

  Future<bool> validationServices() async {
    if (await Geolocator.isLocationServiceEnabled()) {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        return true;
      } else if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          showPermanentDialog(
            context: context,
            icon: Icons.lock_rounded,
            text: 'Разрешение на местоположение не получено',
            function: () async {
              if (!await Geolocator.openAppSettings()) {
                if (mounted) {
                  showOverlay(
                    context: context,
                    overlayEntry: overlayEntry,
                    icon: Icons.app_settings_alt_rounded,
                    text:
                        'Не удается перейти в настройки приложения. Попробуйте вручную',
                  );
                }
              }
              if (mounted) {
                Navigator.pop(context);
              }
            },
            backFunctionText: 'Попробовать снова',
          );
        }
      } else {
        if (mounted) {
          showOverlay(
            context: context,
            overlayEntry: overlayEntry,
            icon: Icons.lock_rounded,
            text: 'Разрешение на местоположение не получено',
          );
        }
      }
    } else {
      if (mounted) {
        showPermanentDialog(
          context: context,
          icon: Icons.location_disabled_rounded,
          text: 'Сервисы геолокации отключены',
          function: () async {
            if (!await Geolocator.openLocationSettings()) {
              if (mounted) {
                showOverlay(
                  context: context,
                  overlayEntry: overlayEntry,
                  icon: Icons.app_settings_alt_rounded,
                  text:
                      'Не удается перейти в настройки местоположения. Попробуйте вручную',
                );
              }
            }
            if (mounted) {
              Navigator.pop(context);
            }
          },
        );
      }
    }
    return false;
  }

  getPosition() async {
    if (await validationServices()) {
      Position position = await Geolocator.getCurrentPosition();
      widget.setMyLocation(position);
    }
  }

  setListenerPosition() async {
    if (await validationServices()) {
      _positionSubscription = Geolocator.getPositionStream().listen(
        (position) {
          widget.setMyLocation(position);
        },
      );
    }
  }

  removeListenerPosition() {
    _positionSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 7,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AutocompleteForm(),
          ElevatedButton(
            onLongPress: setListenerPosition,
            onPressed: getPosition,
            style: const ButtonStyle(
              padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
            ),
            child: Text(
              'Вызвать такси',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.black,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
