import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const FaIcon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 30,
              )),
          const SizedBox(
            height: 50,
          ),
          DelayedDisplay(
            delay: const Duration(seconds: 1),
            fadeIn: true,
            child: Center(
              child: Image.asset(
                'assets/brando_white.png',
                colorBlendMode: BlendMode.clear,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
