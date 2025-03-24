import 'package:flutter/material.dart';
import 'package:ssnhi_app/users/guest_screens/for_id_guest/mobile/guest_for_id_mobile.dart';
import 'package:ssnhi_app/users/guest_screens/for_id_guest/web/guest_for_id_web.dart';
import 'package:ssnhi_app/shared/utils/responsive.dart';

class GuestForID extends StatelessWidget {
  const GuestForID({super.key});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context) == true) {
      return const GuestForIdMobile();
    } else {
      return const GuestForIdWeb();

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
