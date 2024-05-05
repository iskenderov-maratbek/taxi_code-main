import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:taxi_code/services/network_service.dart';

class NetworkStatus extends StatefulWidget {
  const NetworkStatus({super.key});

  @override
  State<NetworkStatus> createState() => _NetworkStatusState();
}

class _NetworkStatusState extends State<NetworkStatus>
    with SingleTickerProviderStateMixin {
  bool visibleText = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  showText() {
    if (!visibleText) {
      setState(() {
        visibleText = true;
        _controller.forward();
      });
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          visibleText = false;
          _controller.reverse();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<NetworkService>(
        builder: (BuildContext context, networkService, Widget? child) {
          return Visibility(
            visible: networkService.networkStatus,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.7),
                  border: Border.all(
                    color: Colors.redAccent,
                    width: 2.0,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.wifi_off_rounded,
                      color: Colors.red,
                    ),
                    const Gap(10),
                    Text(
                      'Нет сети',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
