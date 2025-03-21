import 'package:flutter/material.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_model.dart';
import 'package:ssnhi_app/users/screens/dashboard/for_id/view_for_id/mobile/view_for_id_mobile_guest.dart';
import 'package:ssnhi_app/users/screens/dashboard/for_id/view_for_id/web/view_for_id_web_guest.dart';
import 'package:ssnhi_app/shared/utils/responsive.dart';

class ViewForIdGuest extends StatelessWidget {
  final ForIdModel forIdModel;

  const ViewForIdGuest({
    super.key,
    required this.forIdModel,
  });

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return ViewForIdMobileGuest(
        forIdModel: forIdModel,
      );
    } else {
      // return AddForIdWeb(vm: vm);

      return ViewForIdWebGuest(forIdModel: forIdModel);
    }
  }
}
