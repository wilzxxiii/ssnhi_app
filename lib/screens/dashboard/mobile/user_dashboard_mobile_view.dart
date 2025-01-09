import 'package:flutter/material.dart';
import 'package:ssnhi_app/screens/chat/chat_agent.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

class UserDashboardMobileView extends StatelessWidget {
  const UserDashboardMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 10,
        backgroundColor: mainColor,
      ),
      drawer: const Drawer(),
    );
  }
}
