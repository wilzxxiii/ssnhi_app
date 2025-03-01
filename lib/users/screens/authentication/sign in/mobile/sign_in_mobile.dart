import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:ssnhi_app/users/screens/authentication/sign%20in/sign_in/signin_form.dart';

class SignInMobilePage extends StatelessWidget {
  const SignInMobilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: darkBackground,
        onPressed: () {
          Navigator.pop(context);
        },
        child: const FaIcon(
          Icons.arrow_back_ios_new_outlined,
          color: iconColor,
        ),
      ),
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
              Padding(
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
