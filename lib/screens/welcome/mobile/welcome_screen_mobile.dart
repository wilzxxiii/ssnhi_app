import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:ssnhi_app/screens/authentication/sign%20in/sign_in.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:typewritertext/typewritertext.dart';

class WelcomeScreenMobile extends StatelessWidget {
  const WelcomeScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        leading: Image.asset(
          'assets/logo.png',
          height: 80,
        ),
      ),
      floatingActionButton: DelayedDisplay(
        delay: const Duration(seconds: 5),
        child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const SigninPage()));
            },
            backgroundColor: mainColor,
            label: const Text(
              'Use Brando 🤍',
              style: titleStyle,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                height: 400,
                width: 400,
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
                "And that's where the story begins 🖤",
                maintainSize: true,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
                duration: const Duration(milliseconds: 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
