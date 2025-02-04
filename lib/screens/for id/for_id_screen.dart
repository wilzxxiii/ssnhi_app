import 'package:flutter/material.dart';
import 'package:ssnhi_app/screens/for%20id/mobile/for_id_mobile.dart';
import 'package:ssnhi_app/shared/utils/responsive.dart';
// import 'package:ssnhi_app/screens/dashboard/user_dashboard_menu.dart';
// import 'package:ssnhi_app/screens/dashboard/user_dashboard_side_panel.dart';
// import 'package:ssnhi_app/shared/utils/responsive.dart';

class ForID extends StatelessWidget {
  const ForID({super.key});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context) == true) {
      return const ForIdMobile();
    } else {
      return const SafeArea(
        child: Padding(
            padding: EdgeInsets.only(
              left: 150,
              right: 150,
            ),
            child: ForIdMobile()),
      );
    }
  }
}
