import 'package:flutter/material.dart';
import 'package:ssnhi_app/shared/utils/responsive.dart';

import 'package:ssnhi_app/users/screens/it_report_form/mobile/it_report__mobile.dart';
import 'package:ssnhi_app/users/screens/it_report_form/web/it_report_form_web.dart';

class ItReport extends StatelessWidget {
  const ItReport({super.key});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context) == true) {
      return const ItReportMobile();
    } else {
      return const ItReportWeb();
    }
  }
}
