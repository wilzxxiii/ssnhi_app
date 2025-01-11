import 'package:flutter/material.dart';
import 'package:ssnhi_app/screens/welcome/mobile/welcome_screen_mobile.dart';
import 'package:ssnhi_app/screens/welcome/web/welcome_screen_web.dart';
import 'package:ssnhi_app/shared/utils/responsive.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context) == true) {
      return const WelcomeScreenMobile();
    } else {
      return const WelcomeScreenWeb();
    }
  }
}
