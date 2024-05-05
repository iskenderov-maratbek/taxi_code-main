import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:taxi_code/auth/auth.dart';
import 'package:taxi_code/auth/auth_pages/register_page/new_password_register.dart';
import 'package:taxi_code/auth/auth_pages/register_page/phone_number_register.dart';
import 'package:taxi_code/auth/auth_pages/register_page/username_register.dart';
import 'package:taxi_code/auth/auth_pages/restore_page/new_password_restore.dart';
import 'package:taxi_code/auth/auth_pages/restore_page/phone_number_restore.dart';
import 'package:taxi_code/home.dart';
import 'package:taxi_code/menu/menu_items/account.dart';
import 'package:taxi_code/menu/menu_items/history.dart';
import 'package:taxi_code/menu/menu_items/settings.dart';
import 'package:taxi_code/services/auth_service.dart';
import 'package:taxi_code/custom_transition.dart';
import 'package:taxi_code/palette.dart' as palette;
import 'package:taxi_code/services/network_service.dart';
import 'package:taxi_code/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(create: (_) => AuthService()),
        ChangeNotifierProvider<NetworkService>(create: (_) => NetworkService()),
      ],
      child: const TaxiCode(),
    ),
  );
}

class TaxiCode extends StatelessWidget {
  const TaxiCode({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, Widget> onGenerateRoute = {
      '/': const SplashScreen(),
      '/home': const Home(),
      '/auth': const Auth(),
      '/register': const PhoneNumberRegister(),
      '/restore': const PhoneNumberRestore(),
      '/new_password_register': const NewPasswordRegister(),
      '/new_password_restore': const NewPasswordRestore(),
      '/username_register': const UsernameRegister(),
      '/settings': const Settings(),
      '/account': const Account(),
      '/history': const History(),
    };

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taxi Code',
      theme: theme(context),
      home: const SplashScreen(),
      onGenerateRoute: (settings) {
        return CustomRoute(
          builder: (context) => onGenerateRoute[settings.name]!,
        );
      },
    );
  }

  ThemeData theme(BuildContext context) {
    return ThemeData(
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CustomCupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CustomCupertinoPageTransitionsBuilder(),
        },
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: palette.yellow,
        selectionColor: palette.blue,
        selectionHandleColor: palette.yellow,
      ),
      scaffoldBackgroundColor: Colors.black,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(color: Colors.grey),
        floatingLabelStyle: const TextStyle(
          fontSize: 20,
          color: palette.yellow,
        ),
        suffixIconColor: palette.white,
        filled: true,
        fillColor: palette.textFieldFillColor,
        labelStyle: const TextStyle(
          fontSize: 20,
          color: palette.white,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: palette.yellow),
          borderRadius: BorderRadius.circular(20),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: palette.red),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: palette.yellow),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: palette.yellow,
          foregroundColor: palette.grey,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          iconColor: MaterialStateProperty.all<Color>(palette.yellow),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              side: const BorderSide(color: palette.yellow),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          backgroundColor:
              MaterialStateProperty.resolveWith((Set<MaterialState> state) {
            if (state.contains(MaterialState.pressed)) {
              return Colors.grey[700];
            } else if (state.contains(MaterialState.selected)) {
              return Colors.black;
            }
            return Colors.black;
          }),
        ),
      ),
      dialogTheme: const DialogTheme(
        backgroundColor: Colors.black,
        surfaceTintColor: Colors.transparent,
      ),
      textTheme: GoogleFonts.nunitoTextTheme(
        Theme.of(context).textTheme.apply(bodyColor: Colors.white),
      ),
    );
  }
}
