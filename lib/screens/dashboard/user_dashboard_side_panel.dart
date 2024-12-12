import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:ssnhi_app/data/repo/user_firebase.dart';

class UserDashboardSidePanel extends StatelessWidget {
  const UserDashboardSidePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseRepo = UserFirebaseRepository();
    return GestureDetector(
      onTap: () {
        firebaseRepo.logOut();
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: Colors.lightBlueAccent),
        child: Center(
          child: DelayedDisplay(
            delay: const Duration(seconds: 1),
            fadeIn: true,
            child: Image.asset(
              'assets/ssnhinc.png',
              colorBlendMode: BlendMode.clear,
            ),
          ),
        ),
      ),
    );
  }
}
