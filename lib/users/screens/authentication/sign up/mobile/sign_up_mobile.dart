import 'package:flutter/material.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:ssnhi_app/users/screens/authentication/sign%20up/sign_up/sign_up_form.dart';

class SignUpMobile extends StatelessWidget {
  const SignUpMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'logo_white.png',

          // height: 93,
        ),
        title: const Text(
          'Believe in something 🌙',
          style: titleStyle,
        ),
        centerTitle: true,
        backgroundColor: darkBackground,
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
      ),
      body: const SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Padding(
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
