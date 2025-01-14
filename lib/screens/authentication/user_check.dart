import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:ssnhi_app/screens/authentication/email_verification_screen.dart';
import 'package:ssnhi_app/screens/authentication/sign%20in/sign_in.dart';
import 'package:ssnhi_app/screens/dashboard/user_dashboard.dart';

import 'package:ssnhi_app/screens/loading_screen.dart';

class UserChecker extends StatelessWidget {
  const UserChecker({super.key});

  @override
  Widget build(BuildContext context) {
    // final userRepo = UserFirebaseRepository();
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        }

        if (snapshot.hasData) {
          User? user = FirebaseAuth.instance.currentUser;

          if (user!.emailVerified == true) {
            // userRepo.getMyUser(user.uid);
            // return JuneBuilder(() => GetUserInfo.instance, builder: (vm) {
            //   return const UserDashboard();
            // });

            return const UserDashboard();
          } else {
            return const EmailVerificationScreen();
          }
        } else {
          return const SigninPage();
        }

        // return const CircularProgressIndicator();
      },
    );
  }
}
