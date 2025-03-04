import 'package:flutter/material.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_model.dart';
import 'package:ssnhi_app/shared/utils/responsive.dart';
import 'package:ssnhi_app/users/screens/for_id/view_for_id/mobile/view_for_id_mobile.dart';
import 'package:ssnhi_app/users/screens/for_id/view_for_id/web/view_for_id_web.dart';

class ViewForId extends StatelessWidget {
  final ForIdModel forIdModel;

  const ViewForId({
    super.key,
    required this.forIdModel,
  });

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return ViewForIdMobile(
        forIdModel: forIdModel,
      );
    } else {
      // return AddForIdWeb(vm: vm);

      return ViewForIdWeb(forIdModel: forIdModel);
    }
  }
}
