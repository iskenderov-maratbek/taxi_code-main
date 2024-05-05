import 'package:flutter/material.dart';

class LoadingService extends StatelessWidget {
  const LoadingService({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.black,
      child: Container(
        margin: const EdgeInsets.all(15),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Column(children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 10),
          Text(message),
        ]),
      ),
    );
  }
}
