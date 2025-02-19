import 'package:flutter/material.dart';
import 'package:ssnhi_app/users/screens/authentication/sign%20in/mobile/sign_in_mobile.dart';
import 'package:ssnhi_app/users/screens/authentication/sign%20in/web/sign_in_web.dart';
import 'package:ssnhi_app/shared/utils/responsive.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    // return JuneBuilder(() => AppState(), builder: (appState) {

    //   if (Responsive.isMobile(context) == true) {
    //     return const SignInMobilePage();
    //   } else {
    //     return const SigninWebPage();
    //   }
    // },);
    if (Responsive.isMobile(context) == true) {
      return const SignInMobilePage();
    } else {
      return const SigninWebPage();
    }
  }
}
