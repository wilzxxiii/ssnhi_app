import 'package:flutter/material.dart';
import 'package:ssnhi_app/screens/authentication/sign%20up/mobile/sign_up_mobile.dart';
import 'package:ssnhi_app/screens/authentication/sign%20up/web/sign_up_web.dart';
import 'package:ssnhi_app/shared/utils/responsive.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context) == true) {
      return const SignUpMobile();
    } else {
      return const SignUpWebPage();
    }
  }
}
