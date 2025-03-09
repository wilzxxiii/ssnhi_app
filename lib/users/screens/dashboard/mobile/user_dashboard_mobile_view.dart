import 'package:flutter/material.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:ssnhi_app/users/screens/dashboard/mobile/user_dashboard_mobile_drawer.dart';

class UserDashboardMobileView extends StatelessWidget {
  const UserDashboardMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => const ChatAgentSreen()));
      //   },
      //   backgroundColor: mainColor,
      //   hoverColor: hoverColor,
      //   tooltip: 'Chat with AI',
      //   child: const Icon(
      //     Icons.chat,
      //     color: Colors.white,
      //   ),
      // ),
      drawer: const UserDashboardMobileDrawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: iconColor),
        centerTitle: true,
        title: const Text(
          'Brando ❤️‍🔥',
          style: titleStyle,
        ),
        toolbarHeight: 80,
        elevation: 10,
        backgroundColor: mainColor,
      ),
    );
  }
}
