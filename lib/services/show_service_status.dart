import 'dart:ui';
import 'package:taxi_code/palette.dart' as palette;
import 'package:flutter/material.dart';

showDialogInfo({context, icon, text, confirmButtonText, confirmButtonPressed}) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: AlertDialog(
            backgroundColor: palette.transparent,
            surfaceTintColor: palette.transparent,
            title: Text(
              text,
              textAlign: TextAlign.center,
            ),
            actionsOverflowAlignment: OverflowBarAlignment.center,
            // actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              ElevatedButton(
                child: Text(confirmButtonText),
                onPressed: () {
                  confirmButtonPressed();
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: const Text('Назад'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      });
}

showPermanentDialog(
    {required context,
    required icon,
    required text,
    required function,
    backFunctionText = 'Назад'}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: PopScope(
          canPop: false,
          child: AlertDialog(
            backgroundColor: palette.transparent,
            surfaceTintColor: palette.transparent,
            title: Icon(
              icon,
              size: 100,
              color: Colors.red,
            ),
            content: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 30),
            ),
            actions: [
              ElevatedButton(
                onPressed: function,
                child: const Text('Перейти к настройкам'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(backFunctionText),
              ),
            ],
            actionsOverflowAlignment: OverflowBarAlignment.center,
          ),
        ),
      );
    },
  );
}

void showOverlay({
  required context,
  required overlayEntry,
  required icon,
  required text,
}) async {
  remove(e) {
    if (overlayEntry.mounted) {
      overlayEntry.remove();
    }
  }

  overlayEntry = OverlayEntry(
    builder: (context) => Listener(
      onPointerDown: remove,
      child: Align(
        alignment: Alignment.center,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Scaffold(
            backgroundColor: palette.transparentBlack,
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: palette.red,
                    size: 100,
                  ),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
  Overlay.of(context).insert(overlayEntry);
  Future.delayed(const Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}
