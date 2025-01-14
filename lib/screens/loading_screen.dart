import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DelayedDisplay(
            delay: const Duration(seconds: 1),
            fadeIn: true,
            child: SizedBox(
              height: 250,
              width: 250,
              child: Image.asset(
                'assets/logo.png',
                colorBlendMode: BlendMode.clear,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const SpinKitCircle(
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
