import 'package:flutter/material.dart';
import 'package:ssnhi_app/screens/authentication/sign%20in/sign_in/signin_form.dart';

class SignInMobilePage extends StatelessWidget {
  const SignInMobilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 95,
                child: Image.asset(
                  'logo.png',

                  // height: 93,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: SigninForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
