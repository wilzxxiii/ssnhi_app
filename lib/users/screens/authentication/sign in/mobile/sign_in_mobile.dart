import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:ssnhi_app/users/screens/authentication/sign%20in/sign_in/signin_form.dart';

class SignInMobilePage extends StatelessWidget {
  const SignInMobilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const FaIcon(
            Icons.arrow_back_ios_new_outlined,
            color: iconColor,
          ),
        ),
        title: const Text(
          appTitle,
          style: titleStyle,
        ),
        centerTitle: false,
        backgroundColor: darkBackground,
        automaticallyImplyLeading: false,
        toolbarHeight: appBarHeight,
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
