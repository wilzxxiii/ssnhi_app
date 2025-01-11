import 'package:flutter/material.dart';
import 'package:ssnhi_app/screens/authentication/sign%20in/mobile/sign_in_mobile.dart';
import 'package:ssnhi_app/screens/authentication/sign%20in/web/sign_in_web.dart';
import 'package:ssnhi_app/shared/utils/responsive.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context) == true) {
      return const SignInMobilePage();
    } else {
      return const SigninWebPage();
    }
  }
}
