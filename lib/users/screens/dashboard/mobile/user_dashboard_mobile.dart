import 'package:flutter/material.dart';
import 'package:june/june.dart';
import 'package:ssnhi_app/users/screens/dashboard/jo/maintenance_jo.dart';
import 'package:ssnhi_app/users/screens/dashboard/mobile/user_dashboard_mobile_view.dart';
import 'package:ssnhi_app/users/screens/dashboard/state/dashboard_state.dart';
// import 'package:ssnhi_app/users/screens/dashboard/user_dashboard.dart';
import 'package:ssnhi_app/users/screens/for_id/for_id_screen.dart';
import 'package:ssnhi_app/users/screens/it_report_form/it_report_form.dart';

class UserDashboardMobile extends StatelessWidget {
  const UserDashboardMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return JuneBuilder(
      () => DashboardState(),
      builder: (webState) {
        if (webState.moonDashboard == true) {
          return const UserDashboardMobileView();
        }
        if (webState.moonForId == true) {
          return const ForID();
        }
        if (webState.moonForItreport == true) {
          return const ItReport();
        }
        if (webState.moonForJo == true) {
          return const MaintenanceJo();
        }

        return const CircularProgressIndicator();
        // return webState.moonDashboard
        //     ? const UserDashboardMobileView()
        //     : webState.moonForId
        //         ? const ForID()
        //         : webState.moonForItreport
        //             ? const ItReport()
        //             : webState.moonForJo
        //                 ? const MaintenanceJo()
        //                 : const UserDashboardMobileView();
      },
    );
  }
}
