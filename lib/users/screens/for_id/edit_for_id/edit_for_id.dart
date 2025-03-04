import 'package:flutter/material.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_model.dart';

import 'package:ssnhi_app/shared/utils/responsive.dart';
import 'package:ssnhi_app/users/screens/for_id/edit_for_id/mobile/edit_for_id_mobile.dart';
import 'package:ssnhi_app/users/screens/for_id/edit_for_id/web/edit_for_id_web.dart';

class EditForId extends StatelessWidget {
  final ForIdModel forIdModel;

  const EditForId({
    super.key,
    required this.forIdModel,
  });

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return EditForIdMobile(
        forIdModel: forIdModel,
      );
    } else {
      // return AddForIdWeb(vm: vm);

      return EditForIdWeb(forIdModel: forIdModel);
    }
  }
}
