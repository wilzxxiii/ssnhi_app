import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:june/june.dart';
import 'package:ssnhi_app/data/user/state/auth_state_june.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

class UserDashboardAppbar extends StatelessWidget {
  const UserDashboardAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = June.getState(() => AuthState());
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // DelayedDisplay(
            //   delay: const Duration(milliseconds: 300),
            //   child: SizedBox(
            //     height: 80,
            //     child: CircleAvatar(
            //       backgroundColor: lightBackground,
            //       radius: 80,
            //       child: Image.asset('ssnhinc.png'),
            //     ),
            //   ),
            // ),
            DelayedDisplay(
              delay: const Duration(milliseconds: 300),
              child: SizedBox(
                height: 95,
                child: Image.asset(
                  'brando_white.png',
                  fit: BoxFit.fitHeight,
                  height: 93,
                ),
              ),
            ),
            const SizedBox(
              width: 140,
            ),
            DelayedDisplay(
              delay: const Duration(milliseconds: 500),
              child: Text(
                "Welcome, ${authState.user!.name} ✨",
                style: titleStyle,
              ),
            ),
            const SizedBox(
              width: 100,
            ),
            TextButton(
              onPressed: () async {
                await authState.userLogOut(context);
              },
              child: const Text(
                'Log out',
                style: titleStyle,
              ),
            )
            // const SizedBox(
            //   width: 300,
            // ),
            // const Text(
            //   'Keep on building',
            //   style: titleStyle,
            // ),
          ],
        ),
      ),
    );
  }
}
