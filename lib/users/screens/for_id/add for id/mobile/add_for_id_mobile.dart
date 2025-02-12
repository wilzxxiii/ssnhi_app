import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:june/june.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_state.dart';

import 'package:ssnhi_app/users/screens/for_id/add%20for%20id/mobile/add_for_id_mobile_body.dart';
// import 'package:ssnhi_app/screens/chat/chat_agent.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

class AddForIdMobile extends StatelessWidget {
  const AddForIdMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return JuneBuilder(
      () => ForIdState(),
      builder: (vm) {
        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              if (vm.formKey.currentState!.validate()) {
                try {
                  await vm.saveData();
                } catch (e) {
                  log(e.toString());
                }
              } else {
                log('Something is wrong');
              }
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
                vm.clearControllers();
                vm.clearForIdModel();
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
          body: AddForIdMobileBody(vm: vm),
        );
      },
    );
  }
}
