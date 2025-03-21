import 'package:flutter/material.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

class ChatAgentSreen extends StatelessWidget {
  const ChatAgentSreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: iconColor,
            )),
        toolbarHeight: 70,
        elevation: 10,
        title: const Text(
          'Brando, your AI assistant ✨',
          style: titleStyle,
        ),
        backgroundColor: mainColor,
      ),
    );
  }
}
