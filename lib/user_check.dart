import 'package:flutter/material.dart';
import 'package:june/june.dart';
import 'package:ssnhi_app/data/user/state/auth_state_june.dart';
import 'package:ssnhi_app/email_verification_screen.dart';
import 'package:ssnhi_app/guest/screens/guest_dashboard/guest_dashboard.dart';
import 'package:ssnhi_app/users/screens/dashboard/user_dashboard.dart';

class UserChecker extends StatelessWidget {
  const UserChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return JuneBuilder(
      () => AuthState(),
      builder: (authState) {
        if (authState.user != null) {
          // return const WelcomeScreen();
          if (authState.user!.emailVerified) {
            return const UserDashboard();
          } else {
            return const EmailVerificationScreen();
          }
        } else {
          return const GuestDashboard();
        }
      },
    );
  }
}
