import 'package:flutter/material.dart';
import 'package:june/june.dart';
import 'package:ssnhi_app/data/user/state/app_state_june.dart';
import 'package:ssnhi_app/screens/authentication/user_check.dart';
import 'package:ssnhi_app/screens/loading_screen.dart';

class AppStateCheck extends StatelessWidget {
  const AppStateCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return JuneBuilder(() => AppState(), builder: (appState) {
      if (appState.isLoading) {
        print('loading');
        return const LoadingScreen();
      } else {
        print('loaded');
        return const UserChecker();
      }
    });
  }
}
