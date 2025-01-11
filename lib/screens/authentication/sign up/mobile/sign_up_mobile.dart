import 'package:flutter/material.dart';
import 'package:ssnhi_app/screens/authentication/sign%20up/sign_up/sign_up_form.dart';

class SignUpMobile extends StatelessWidget {
  const SignUpMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
            const SignUpForm(),
          ],
        ),
      ),
    );
  }
}
