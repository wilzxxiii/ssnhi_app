import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:june/june.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_state.dart';
// import 'package:ssnhi_app/screens/chat/chat_agent.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:ssnhi_app/users/screens/for_id/add_for_id/add_for_id_body.dart';

class AddForId extends StatelessWidget {
  final ForIdState vm;
  const AddForId({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    final forIdState = June.getState(() => ForIdState());
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: iconColor),
        leading: IconButton(
          onPressed: () {
            vm.clearControllers();
            vm.clearForIdModel();
            Navigator.pop(context);
          },
          icon: const FaIcon(Icons.close_rounded),
        ),
        title: const Text(
          'Add Record 💫',
          style: titleStyle,
        ),
        toolbarHeight: appBarHeight,
        backgroundColor: darkBackground,
        actions: [
          IconButton(
            onPressed: () async {
              await forIdState.saveData(context);
            },
            icon: const FaIcon(
              Icons.save,
              color: lightBackground,
              size: 20,
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: AddForIdBody(vm: vm),
    );
  }
}
