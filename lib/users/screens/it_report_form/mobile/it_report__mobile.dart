import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

class ItReportMobile extends StatelessWidget {
  const ItReportMobile({super.key});

  @override
  Widget build(BuildContext context) {
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
            // webState.showMoonDashboard();
            Navigator.pop(context);
          },
          icon: const FaIcon(Icons.arrow_back_ios_new),
        ),
      ),
    );
  }
}
