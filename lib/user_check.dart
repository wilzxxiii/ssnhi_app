import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:june/june.dart';
import 'package:ssnhi_app/data/user/state/auth_state_june.dart';
import 'package:ssnhi_app/users/screens/authentication/email_verification_screen.dart';
import 'package:ssnhi_app/guest/screens/guest_dashboard/guest_dashboard.dart';
import 'package:ssnhi_app/users/screens/dashboard/user_dashboard.dart';

class UserChecker extends StatelessWidget {
  const UserChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return JuneBuilder(
      () => AuthState(), // Still works with singleton
      builder: (authState) {
        print(
            'UserChecker build, user: ${authState.user?.email}, isLoading: ${authState.isLoading}');
        if (authState.isLoading) {
          print('AuthState is loading');
          return const Center(
            child: SpinKitFoldingCube(color: Colors.black),
          );
        }
        if (authState.user != null) {
          print('User is signed in');
          if (authState.user!.emailVerified) {
            print('user is verified');
            return const UserDashboard();
          } else {
            return const EmailVerificationScreen();
          }
        } else {
          print('Checker is loading');
          print('User is empty');
          return const GuestDashboard();
        }
      },
    );
  }
}
