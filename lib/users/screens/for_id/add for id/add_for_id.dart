import 'package:flutter/material.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_state.dart';
import 'package:ssnhi_app/users/screens/for_id/add%20for%20id/mobile/add_for_id_mobile.dart';
import 'package:ssnhi_app/shared/utils/responsive.dart';
// import 'package:ssnhi_app/screens/dashboard/user_dashboard_menu.dart';
// import 'package:ssnhi_app/screens/dashboard/user_dashboard_side_panel.dart';
// import 'package:ssnhi_app/shared/utils/responsive.dart';

class AddForID extends StatelessWidget {
  // final forIdFormKey = GlobalKey<FormState>();
  final ForIdState vm;
  const AddForID({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return AddForIdMobile(vm: vm);
    } else {
      // return AddForIdWeb(vm: vm);

      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 150,
            right: 150,
          ),
          child: AddForIdMobile(vm: vm),
        ),
      );
    }
  }
}
