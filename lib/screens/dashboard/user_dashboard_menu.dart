import 'package:flutter/material.dart';
import 'package:ssnhi_app/shared/utils/responsive.dart';

class UserDashboardMenu extends StatelessWidget {
  const UserDashboardMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Responsive.isDesktop(context)
          ? const EdgeInsets.all(100)
          : const EdgeInsets.all(20),
      child: const SafeArea(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
