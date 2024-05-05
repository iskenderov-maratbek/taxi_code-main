// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// // ChangeNotifier для управления состоянием авторизации
// class AuthProvider extends ChangeNotifier {
//   bool _isAuthenticated = false;

//   bool get isAuthenticated => _isAuthenticated;

//   // Метод для проверки авторизации
//   void checkAuthentication() {
//     // Ваша логика проверки авторизации здесь
//     // Замените этот код на вашу реальную логику проверки
//     _isAuthenticated = false; // Пример: по умолчанию не аутентифицирован

//     // Если пользователь не аутентифицирован, отобразите AlertDialog
//     if (!_isAuthenticated) {
//       _showAlertDialog();
//     }

//     // Уведомляем слушателей об изменении состояния
//     notifyListeners();
//   }

//   // Метод для отображения AlertDialog
//   void _showAlertDialog() {
//     // Ваш код для отображения AlertDialog
//     // Используйте BuildContext для доступа к контексту
//     // Замените этот код на вашу реальную реализацию AlertDialog
//     showDialog(
//       context: // Ваш контекст,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Не аутентифицирован'),
//           content: Text('Пользователь не вошел в аккаунт.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
