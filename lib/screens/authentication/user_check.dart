import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:ssnhi_app/screens/authentication/email_verification_screen.dart';
import 'package:ssnhi_app/screens/authentication/sign_in.dart';

import 'package:ssnhi_app/screens/dashboard/user_dashboard.dart';

class UserChecker extends StatelessWidget {
  const UserChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasData) {
          User? user = FirebaseAuth.instance.currentUser;
          if (user!.emailVerified == true) {
            return const UserDashboard();
          } else {
            return const EmailVerificationScreen();
          }
        } else {
          return const SigninPage();
        }
      },
    );
  }
}
