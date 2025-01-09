import 'package:flutter/material.dart';
import 'package:ssnhi_app/screens/chat/chat_agent.dart';
import 'package:ssnhi_app/screens/dashboard/user_dashboard_appbar.dart';
import 'package:ssnhi_app/screens/dashboard/web/user_dashboard_web_body.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

class UserDashboardWebView extends StatelessWidget {
  const UserDashboardWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ChatAgentSreen()));
        },
        backgroundColor: mainColor,
        tooltip: 'Chat with AI',
        child: const Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),
      body: const SafeArea(
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
