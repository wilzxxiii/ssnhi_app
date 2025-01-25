import 'package:flutter/material.dart';
import 'package:june/state_manager/src/simple/state.dart';
import 'package:ssnhi_app/data/user/state/auth_state_june.dart';
import 'package:ssnhi_app/screens/authentication/email_verification_screen.dart';
import 'package:ssnhi_app/screens/dashboard/user_dashboard.dart';
import 'package:ssnhi_app/screens/welcome/welcome_screen.dart';

class UserChecker extends StatelessWidget {
  const UserChecker({super.key});

  @override
  Widget build(BuildContext context) {
    // final userRepo = UserFirebaseRepository();
    return JuneBuilder(
      () => AuthState(),
      builder: (authState) {
        if (authState.user == null) {
          return const WelcomeScreen();
        } else {
          if (authState.user!.emailVerified) {
            return const UserDashboard();
          } else {
            return const EmailVerificationScreen();
          }
        }
      },
    );
  }
}
