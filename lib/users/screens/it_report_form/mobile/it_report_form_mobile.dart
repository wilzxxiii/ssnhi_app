import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:june/june.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:ssnhi_app/user_check.dart';
import 'package:ssnhi_app/users/screens/dashboard/state/dashboard_state.dart';

class ItReportMobile extends StatelessWidget {
  const ItReportMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final webState = June.getState(() => DashboardState());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: darkBackground,
        title: const Text(
          'IT Report 💫',
          style: titleStyle,
        ),
        iconTheme: const IconThemeData(color: iconColor),
        leading: IconButton(
          onPressed: () {
            // vm.clearForIdModel();
            // vm.clearControllers();
            // vm.canEdit = false;
            webState.showMoonDashboard();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserChecker(),
                ),
                (r) => false);
          },
          icon: const FaIcon(Icons.arrow_back_ios_new),
        ),
      ),
    );
  }
}
