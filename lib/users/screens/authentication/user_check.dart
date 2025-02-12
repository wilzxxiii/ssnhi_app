import 'package:flutter/material.dart';
import 'package:june/june.dart';
import 'package:ssnhi_app/data/user/state/app_state_june.dart';
import 'package:ssnhi_app/data/user/state/auth_state_june.dart';
import 'package:ssnhi_app/users/screens/authentication/email_verification_screen.dart';
import 'package:ssnhi_app/users/screens/dashboard/user_dashboard.dart';
import 'package:ssnhi_app/users/screens/loading_screen.dart';
import 'package:ssnhi_app/users/screens/welcome/welcome_screen.dart';

class UserChecker extends StatelessWidget {
  const UserChecker({super.key});

  @override
  Widget build(BuildContext context) {
    final appStatus = June.getState(() => AppState());
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
          return appStatus.isLoading
              ? const LoadingScreen()
              : const WelcomeScreen();
        }
      },
    );
  }
}
