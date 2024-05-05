import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:taxi_code/auth/auth.dart';
import 'package:taxi_code/custom_transition.dart';
import 'package:taxi_code/home.dart';
import 'package:taxi_code/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthService authService;

  @override
  void initState() {
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    authService = Provider.of<AuthService>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Future.delayed(
          const Duration(seconds: 3),
          () async {
            await authService.checkAuth() && mounted
                ? Navigator.of(context).push(
                    CustomRoute(
                      duration: const Duration(milliseconds: 1300),
                      maintainState: false,
                      builder: (context) => const Home(),
                    ),
                  )
                : Navigator.of(context).push(
                    CustomRoute(
                      duration: const Duration(milliseconds: 1300),
                      maintainState: false,
                      builder: (context) => const Auth(),
                    ),
                  );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    authService.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Center(
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.contain,
            width: MediaQuery.of(context).size.width * 0.45,
          ),
        ),
      ),
    );
  }
}
