import 'package:flutter/material.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

class ChatAgentMobilescreen extends StatefulWidget {
  const ChatAgentMobilescreen({super.key});

  @override
  State<ChatAgentMobilescreen> createState() => _ChatAgentMobilescreenState();
}

class _ChatAgentMobilescreenState extends State<ChatAgentMobilescreen> {
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
        toolbarHeight: 100,
        elevation: 10,
        title: const Text(
          'Chat with Brando, your AI assistant',
          style: titleStyle,
        ),
        backgroundColor: mainColor,
      ),
    );
  }
}
