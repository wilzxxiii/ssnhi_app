import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

class UserDashboardAppbar extends StatelessWidget {
  const UserDashboardAppbar({super.key});

  @override
  Widget build(BuildContext context) {
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
          children: [
            DelayedDisplay(
              delay: const Duration(milliseconds: 300),
              child: SizedBox(
                height: 80,
                child: CircleAvatar(
                  backgroundColor: lightBackground,
                  radius: 80,
                  child: Image.asset('ssnhinc.png'),
                ),
              ),
            ),
            const SizedBox(
              width: 500,
            ),
            const Text(
              'Keep Building',
              style: titleStyle,
            )
          ],
        ),
      ),
    );
  }
}
