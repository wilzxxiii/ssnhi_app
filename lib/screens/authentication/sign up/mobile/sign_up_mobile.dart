import 'package:flutter/material.dart';
import 'package:ssnhi_app/screens/authentication/sign%20up/sign_up/sign_up_form.dart';

class SignUpMobile extends StatelessWidget {
  const SignUpMobile({super.key});

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
                padding: EdgeInsets.only(left: 20, right: 20),
                child: SignUpForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
