import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:ssnhi_app/user_check.dart';
import 'package:typewritertext/typewritertext.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: DelayedDisplay(
        delay: const Duration(seconds: 5),
        child: FloatingActionButton.extended(
            hoverColor: hoverColor,
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserChecker(),
                  ),
                  (r) => false);
            },
            backgroundColor: mainColor,
            label: const Text(
              'See what\'s inside 👀',
              style: titleStyle,
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 20,
              ),
              TypeWriter.text(
                "I asked Joemarie for a name, and he said",
                maintainSize: true,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
                duration: const Duration(milliseconds: 50),
              ),
              Center(
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: DelayedDisplay(
                    delay: const Duration(seconds: 3),
                    fadeIn: true,
                    child: Image.asset(
                      'assets/brando_black.png',
                      colorBlendMode: BlendMode.clear,
                    ),
                  ),
                ),
              ),
              DelayedDisplay(
                delay: const Duration(seconds: 4),
                child: TypeWriter.text(
                  "then this project was made  🖤",
                  maintainSize: true,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                  duration: const Duration(milliseconds: 50),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
