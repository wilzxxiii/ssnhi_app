import 'package:flutter/material.dart';
import 'package:june/june.dart';
import 'package:ssnhi_app/data/user/state/app_state_june.dart';
import 'package:ssnhi_app/users/screens/authentication/user_check.dart';
import 'package:ssnhi_app/users/screens/loading_screen.dart';

class AppStateCheck extends StatelessWidget {
  const AppStateCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return JuneBuilder(() => AppState(), builder: (appState) {
      if (appState.isLoading == true) {
        return const LoadingScreen();
      } else {
        return const UserChecker();
      }
    });
  }
}
