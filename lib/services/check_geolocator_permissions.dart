// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:taxi_code/services/show_service_status.dart'
//     show showDialogInfo, showPopUpOverlay;

// locationPermissionStatus(context) async {
//   var status = await Permission.location.request();
//   print(status);
//   if (status.isDenied) {
//     await showPopUpOverlay(
//       context: context,
//       icon: Icons.gpp_maybe_rounded,
//       text: 'Разрешение на геолокацию отклонено',
//     );
//     return false;
//     // Разрешение не предоставлено
//   } else if (status.isPermanentlyDenied) {
//     showDialogInfo(
//       context: context,
//       icon: Icons.report_problem_rounded,
//       text: 'Доступ к геолокации запрещен',
//       confirmButtonText: 'Перейти к настройкам',
//       confirmButtonPressed: openAppSettings,
//     );
//     // Пользователь навсегда отказал в предоставлении разрешения, можно направить его к настройкам
//     return false;
//   }
//   // if (status.isGranted) {
//   //   return await Geolocator.getCurrentPosition(
//   //     desiredAccuracy: LocationAccuracy.high,
//   //   );
//   // }

//   // Этот блок кода будет вызываться при любом изменении статуса разрешения на местоположение
//   // Может быть полезно для обновления интерфейса или выполнения других действий
// }
