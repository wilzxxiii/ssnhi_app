import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:ssnhi_app/data/user/state/auth_state_june.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

class MaintenanceJoMobile extends StatelessWidget {
  const MaintenanceJoMobile({super.key});

  @override
  Widget build(BuildContext context) {
    // final authState = June.getState(() => AuthState());
    // final webState = June.getState(() => DashboardState());
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // if (authState.user == null) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(
          //       backgroundColor: Colors.red,
          //       content: Text(
          //         'You need an account to add a record. 💀',
          //         style: titleStyle,
          //       ),
          //     ),
          //   );
          // } else {
          //   Navigator.push(context,
          //       MaterialPageRoute(builder: (context) => AddForID(vm: vm)));
          // }
        },
        backgroundColor: mainColor,
        hoverColor: hoverColor,
        tooltip: 'Add record',
        label: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
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
        title: const Text(
          'Maintenance Job Order 💫',
          style: titleStyle,
        ),
        toolbarHeight: 80,
        elevation: 10,
        backgroundColor: mainColor,
      ),
    );
  }
}
