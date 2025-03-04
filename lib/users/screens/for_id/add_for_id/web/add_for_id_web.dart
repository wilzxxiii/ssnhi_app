import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:june/june.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_state.dart';
// import 'package:ssnhi_app/screens/chat/chat_agent.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:ssnhi_app/users/screens/for_id/add_for_id/mobile/add_for_id_mobile_body.dart';

class AddForIdWeb extends StatelessWidget {
  final ForIdState vm;
  const AddForIdWeb({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    final forIdState = June.getState(() => ForIdState());
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 150,
          right: 150,
        ),
        child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              if (vm.forIdformKey.currentState!.validate()) {
                await forIdState.saveData(context);
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
        ),
      ),
    );
  }
}
