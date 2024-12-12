import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

class SignUpSidePanel extends StatelessWidget {
  const SignUpSidePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: Colors.lightBlueAccent),
      child: DelayedDisplay(
        delay: const Duration(seconds: 1),
        fadeIn: true,
        child: Center(
          child: Image.asset(
            'assets/ssnhinc.png',
            colorBlendMode: BlendMode.clear,
          ),
        ),
      ),
    );
  }
}
