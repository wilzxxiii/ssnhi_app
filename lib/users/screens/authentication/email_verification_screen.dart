import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ssnhi_app/app_status.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:typewritertext/typewritertext.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: darkBackground,
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const AppStateCheck()));
          },
          label: const Text(
            'Done ✨',
            style: titleStyle,
          )),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: 200,
                width: 200,
                child: Image.asset(
                  'logo.png',
                  colorBlendMode: BlendMode.clear,
                ),
              ),
            ),
            TypeWriter.text(
              "Thank you for registering",
              maintainSize: true,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
              duration: const Duration(milliseconds: 50),
            ),
            const SizedBox(height: 15),
            TypeWriter.text(
              "Please verify your email address then click done, thanks cute one.",
              maintainSize: true,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
              duration: const Duration(milliseconds: 50),
            ),
            const SizedBox(height: 15),
            const SpinKitPumpingHeart(
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
