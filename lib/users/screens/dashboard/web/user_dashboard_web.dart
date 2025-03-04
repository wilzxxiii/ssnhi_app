import 'package:flutter/material.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:ssnhi_app/users/screens/dashboard/mobile/user_dashboard_mobile_drawer.dart';

class UserDashboardWebView extends StatelessWidget {
  const UserDashboardWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 150,
          right: 150,
        ),
        child: Scaffold(
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
            title: SizedBox(
              height: 100,
              child: Image.asset(
                'brando_white.png',
                height: 93,
              ),
            ),
            toolbarHeight: 80,
            elevation: 10,
            backgroundColor: mainColor,
          ),
        ),
      ),
    );
  }
}
