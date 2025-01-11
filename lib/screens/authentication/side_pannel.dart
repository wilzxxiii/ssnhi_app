import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

class SidePannel extends StatelessWidget {
  const SidePannel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: DelayedDisplay(
        delay: const Duration(seconds: 1),
        fadeIn: true,
        child: Center(
          child: Image.asset(
            'assets/brando_white.png',
            colorBlendMode: BlendMode.clear,
          ),
        ),
      ),
    );
  }
}
