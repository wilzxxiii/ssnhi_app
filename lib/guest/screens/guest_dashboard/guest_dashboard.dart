import 'package:flutter/material.dart';
import 'package:ssnhi_app/guest/screens/guest_dashboard/mobile/guest_dashboard_mobile.dart';
import 'package:ssnhi_app/guest/screens/guest_dashboard/web/guest_dashboard_web.dart';
import 'package:ssnhi_app/shared/utils/responsive.dart';

class GuestDashboard extends StatelessWidget {
  const GuestDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context) == true) {
      return const GuestDashboarMobile();
    } else {
      return const GuestDashboardWeb();
    }
  }
}
