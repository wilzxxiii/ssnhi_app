import 'package:flutter/material.dart';
import 'package:ssnhi_app/screens/authentication/sign%20in/sign_in/signin_form.dart';

class SignInMobilePage extends StatelessWidget {
  const SignInMobilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: SizedBox(
              height: 400,
              width: 400,
              child: Image.asset(
                'logo.png',
                colorBlendMode: BlendMode.clear,
              ),
            ),
          ),
          const SigninForm(),
        ],
      ),
    );
  }
}
