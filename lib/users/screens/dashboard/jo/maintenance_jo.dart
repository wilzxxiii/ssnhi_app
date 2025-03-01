import 'package:flutter/material.dart';
import 'package:ssnhi_app/users/screens/dashboard/jo/mobile/maintenance_jo_mobile.dart';

import 'package:ssnhi_app/shared/utils/responsive.dart';
import 'package:ssnhi_app/users/screens/dashboard/web/user_dashboard_web.dart';
// import 'package:ssnhi_app/screens/dashboard/user_dashboard_menu.dart';
// import 'package:ssnhi_app/screens/dashboard/user_dashboard_side_panel.dart';
// import 'package:ssnhi_app/shared/utils/responsive.dart';

class MaintenanceJo extends StatelessWidget {
  const MaintenanceJo({super.key});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context) == true) {
      return const MaintenanceJoMobile();
    } else {
      return const UserDashboardWebView();
    }
  }
}
