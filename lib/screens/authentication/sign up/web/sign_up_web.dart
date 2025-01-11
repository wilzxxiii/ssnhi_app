import 'package:flutter/material.dart';
import 'package:ssnhi_app/screens/authentication/side_pannel.dart';
import 'package:ssnhi_app/screens/authentication/sign%20up/sign_up/sign_up_form.dart';
import 'package:ssnhi_app/shared/utils/responsive.dart';

class SignUpWebPage extends StatelessWidget {
  const SignUpWebPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            if (!Responsive.isMobile(context))
              Expanded(
                flex: Responsive.isTablet(context) ? 2 : 1,
                child: const SidePannel(),
              ),
            const Expanded(
              flex: 3,
              child: Column(
                children: [
                  // Insert sign in form and widgets corresponding
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Responsive.isMobile(context)
                  //         ? const Text('Already have an account?')
                  //         : const Spacer(),
                  //     TextButton(
                  //         onPressed: () {
                  //           Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: (context) => const SignUpPage()));
                  //         },
                  //         child: const Text('Sign up')),
                  //   ],
                  // ),
                  SignUpForm(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
