import 'package:flutter/material.dart';

class CustomCupertinoPageTransitionsBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const Offset slideToRight = Offset(1, 0);
    const Curve slideCurve = Curves.easeInOutQuint;
    var forwardTransition = Tween<Offset>(
      begin: slideToRight,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: slideCurve,
      ),
    );
    var reverseTransition = Tween<Offset>(
      begin: slideToRight,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOutExpo,
      ),
    );
    return SlideTransition(
      position: animation.status == AnimationStatus.forward
          ? forwardTransition
          : reverseTransition,
      child: child,
    );
  }
}

class CustomRoute extends MaterialPageRoute {
  late Duration duration;
  Duration reverseduration = const Duration(milliseconds: 500);
  CustomRoute({
    required WidgetBuilder builder,
    bool maintainState = true,
    this.duration = const Duration(milliseconds: 700),
  }) : super(builder: builder, maintainState: maintainState);

  @override
  Duration get transitionDuration => duration;

  @override
  Duration get reverseTransitionDuration => reverseduration;
}
