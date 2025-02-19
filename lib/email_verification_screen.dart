import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:june/june.dart';
import 'package:ssnhi_app/data/user/state/auth_state_june.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

import 'package:typewritertext/typewritertext.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = June.getState(() => AuthState());

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          hoverColor: Colors.blue,
          backgroundColor: darkBackground,
          onPressed: () async {
            await authState.userLogOut(context);
          },
          label: const Text(
            'Got it. ✨',
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
            Text(
              'An e-mail was sent to ${authState.user!.email}',
              style: titleStyleDark,
            ),
            const SizedBox(height: 15),
            Text(
              'Please verify it. Thanks ${authState.user!.name}',
              style: titleStyleDark,
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
