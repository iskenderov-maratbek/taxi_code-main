import 'package:flutter/material.dart';
import 'package:taxi_code/network_status.dart';

class PageBuilder extends StatelessWidget {
  final GlobalKey<FormState>? formKey;
  final bool canPop;
  final List<Widget> content;
  const PageBuilder({
    super.key,
    this.formKey,
    required this.content,
    this.canPop = true,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          floatingActionButton: const NetworkStatus(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterTop,
          body: Center(
            child: SingleChildScrollView(
              child: Form(
                  key: formKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Flexible(flex: 1, child: SizedBox()),
                      Flexible(
                          flex: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: content,
                          )),
                      const Flexible(flex: 1, child: SizedBox()),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
