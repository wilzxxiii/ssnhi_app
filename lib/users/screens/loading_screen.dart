import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:typewritertext/typewritertext.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossA,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            TypeWriter.text(
              "Believe in something 🌙",
              textAlign: TextAlign.center,
              softWrap: true,
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              duration: const Duration(milliseconds: 20),
            ),
            const SizedBox(
              height: 60,
            ),
            const SpinKitCircle(
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
