import 'package:flutter/material.dart';
import 'package:ssnhi_app/guest/maintenance/mobile/guest_dashboard_maintenance_mobile.dart';

import 'package:ssnhi_app/shared/utils/responsive.dart';

class GuestDashboardMaintenanceReports extends StatelessWidget {
  const GuestDashboardMaintenanceReports({super.key});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context) == true) {
      return const GuestDashboardMaintenanceReportMobile();
    } else {
      return const Padding(
          padding: EdgeInsets.only(left: 150, right: 150),
          child: GuestDashboardMaintenanceReportMobile());

      // const SafeArea(
      //   child: Padding(
      //       padding: EdgeInsets.only(
      //         left: 150,
      //         right: 150,
      //       ),
      //       child: ForIdMobile()),
      // );
    }
  }
}
