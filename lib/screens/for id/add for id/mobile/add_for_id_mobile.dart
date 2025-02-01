import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:ssnhi_app/screens/chat/chat_agent.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

class AddForIdMobile extends StatelessWidget {
  const AddForIdMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => const ChatAgentSreen()));
        },
        hoverColor: hoverColor,
        backgroundColor: mainColor,
        tooltip: 'Save',
        label: const Text(
          'Save it 💓',
          style: titleStyle,
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: iconColor),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const FaIcon(Icons.arrow_back_ios_new),
        ),
        title: const Text(
          'Add Record 💫',
          style: titleStyle,
        ),
        toolbarHeight: 80,
        elevation: 10,
        backgroundColor: mainColor,
      ),
    );
  }
}
