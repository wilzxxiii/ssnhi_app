import 'package:flutter/material.dart';
import 'package:ssnhi_app/screens/chat/mobile/chat_agent_mobilescreen.dart';

import 'package:ssnhi_app/shared/utils/responsive.dart';

class ChatAgentSreen extends StatelessWidget {
  const ChatAgentSreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context) == true) {
      return const ChatAgentMobilescreen();
    } else {
      return const SafeArea(
        child: Padding(
            padding: EdgeInsets.only(
              left: 150,
              right: 150,
            ),
            child: ChatAgentMobilescreen()),
      );
    }
  }
}
