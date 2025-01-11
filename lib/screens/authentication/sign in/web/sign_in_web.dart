import 'package:flutter/material.dart';
import 'package:ssnhi_app/screens/authentication/side_pannel.dart';
import 'package:ssnhi_app/screens/authentication/sign%20in/sign_in/signin_form.dart';
import 'package:ssnhi_app/shared/utils/responsive.dart';

class SigninWebPage extends StatelessWidget {
  const SigninWebPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            // if (!Responsive.isMobile(context))
            Expanded(
              flex: Responsive.isTablet(context) ? 2 : 1,
              child: const SidePannel(),
            ),
            const Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SigninForm(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
