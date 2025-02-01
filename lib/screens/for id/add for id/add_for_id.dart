import 'package:flutter/material.dart';
import 'package:ssnhi_app/screens/for%20id/add%20for%20id/mobile/add_for_id_mobile.dart';
import 'package:ssnhi_app/shared/utils/responsive.dart';
// import 'package:ssnhi_app/screens/dashboard/user_dashboard_menu.dart';
// import 'package:ssnhi_app/screens/dashboard/user_dashboard_side_panel.dart';
// import 'package:ssnhi_app/shared/utils/responsive.dart';

class AddForID extends StatelessWidget {
  const AddForID({super.key});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context) == true) {
      return const AddForIdMobile();
    } else {
      return const SafeArea(
        child: Padding(
            padding: EdgeInsets.only(
              left: 150,
              right: 150,
            ),
            child: AddForIdMobile()),
      );
    }
  }
}
