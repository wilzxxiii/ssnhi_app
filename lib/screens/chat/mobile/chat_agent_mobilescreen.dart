import 'package:flutter/material.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

class ChatAgentMobilescreen extends StatelessWidget {
  const ChatAgentMobilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        toolbarHeight: 100,
        elevation: 10,
        title: const Text(
          'Pit Senyor AI',
          style: titleStyle,
        ),
        backgroundColor: mainColor,
      ),
      drawer: const Drawer(),
    );
  }
}
