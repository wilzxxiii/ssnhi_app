import 'package:flutter/material.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

class UserDashboardMenu extends StatelessWidget {
  const UserDashboardMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.90,
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
      ),
    );
  }
}
