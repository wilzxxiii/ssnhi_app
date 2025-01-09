import 'package:flutter/material.dart';
import 'package:ssnhi_app/screens/dashboard/user_dashboard_appbar.dart';
import 'package:ssnhi_app/screens/dashboard/web/user_dashboard_web_body.dart';

class ChatAgentWebscreen extends StatelessWidget {
  const ChatAgentWebscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white60,
      body: SafeArea(
        child: Column(
          children: [
            UserDashboardAppbar(),
            UserDashboardWebBody(),
          ],
        ),
      ),
    );
  }
}
