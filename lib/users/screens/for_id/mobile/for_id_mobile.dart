import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ssnhi_app/users/screens/for_id/add%20for%20id/add_for_id.dart';
// import 'package:ssnhi_app/screens/chat/chat_agent.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

class ForIdMobile extends StatelessWidget {
  const ForIdMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddForID()));
        },
        backgroundColor: mainColor,
        hoverColor: hoverColor,
        tooltip: 'Add record',
        label: const Icon(
          Icons.add,
          color: Colors.white,
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
          'List of For ID\'s 💫',
          style: titleStyle,
        ),
        toolbarHeight: 80,
        elevation: 10,
        backgroundColor: mainColor,
      ),
    );
  }
}
