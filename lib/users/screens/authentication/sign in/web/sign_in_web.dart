import 'package:flutter/material.dart';
import 'package:ssnhi_app/users/screens/authentication/side_pannel.dart';
import 'package:ssnhi_app/users/screens/authentication/sign%20in/sign_in/signin_form.dart';
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
              flex: Responsive.isTablet(context) ? 3 : 2,
              child: const SidePannel(),
            ),
            const Expanded(
              flex: 5,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 300, width: 500, child: SigninForm()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
