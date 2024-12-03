import 'package:flutter/material.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Verify your Email Address',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     MaterialButton(
              //       height: kButtonHeight,
              //       minWidth: kButtonWidth,
              //       shape: kButtonShape,
              //       onPressed: () async {
              //         await authService.resendVerificationLink(context);
              //       },
              //       color: kLightTheme,
              //       child: const Text('Resend Verification Link'),
              //     ),
              //     const SizedBox(
              //       width: 15,
              //     ),
              //     MaterialButton(
              //       height: kButtonHeight,
              //       minWidth: kButtonWidth,
              //       shape: kButtonShape,
              //       onPressed: () {},
              //       child: const Text('Log out'),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
