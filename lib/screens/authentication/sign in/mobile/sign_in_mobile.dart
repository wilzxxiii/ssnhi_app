import 'package:flutter/material.dart';
import 'package:ssnhi_app/screens/authentication/sign%20in/sign_in/signin_form.dart';

class SignInMobilePage extends StatelessWidget {
  const SignInMobilePage({super.key});

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
            const SigninForm(),
          ],
        ),
      ),
    );
  }
}
