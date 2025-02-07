import 'package:flutter/material.dart';
import 'package:ssnhi_app/users/screens/dashboard/mobile/user_dashboard_mobile_view.dart';
import 'package:ssnhi_app/shared/utils/responsive.dart';
// import 'package:ssnhi_app/screens/dashboard/user_dashboard_menu.dart';
// import 'package:ssnhi_app/screens/dashboard/user_dashboard_side_panel.dart';
// import 'package:ssnhi_app/shared/utils/responsive.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context) == true) {
      return const UserDashboardMobileView();
    } else {
      return const SafeArea(
        child: Padding(
            padding: EdgeInsets.only(
              left: 150,
              right: 150,
            ),
            child: UserDashboardMobileView()),
      );
    }
  }
}
