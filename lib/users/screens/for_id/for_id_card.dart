import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_model.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_state.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:ssnhi_app/users/screens/for_id/view_for_id/view_for_id.dart';

class ForIdCard extends StatelessWidget {
  const ForIdCard({
    super.key,
    required this.forId,
    required this.vm,
  });

  final ForIdModel forId;
  final ForIdState vm;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(color: Colors.white);
    return Card(
      color: darkBackground,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        minTileHeight: 100,
        // leading: const Icon(
        //   Icons.account_circle,
        //   color: Colors.white,
        // ),
        title: Text(
          'Name: ${forId.empName}',
          style: textStyle,
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    forId.empNo.isEmpty
                        ? 'Employee No: No data'
                        : 'Employee No: ${forId.empNo}',
                    style: textStyle,
                  ),
                  Text(
                    forId.empDept.isEmpty
                        ? 'Department: No chosen department'
                        : 'Department: ${forId.empDept}',
                    style: textStyle,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Status:',
                    style: textStyle,
                  ),
                  forId.status.isEmpty
                      ? const Text(
                          'No status ',
                          style: textStyle,
                        )
                      : Text(
                          forId.status,
                          style: textStyle,
                        ),
                  if (forId.status == 'Gathering Info')
                    const SpinKitPulse(
                      size: 14,
                      color: Colors.red,
                    ),
                  if (forId.status == 'Working')
                    const SpinKitPulse(
                      size: 14,
                      color: Colors.orange,
                    ),
                  if (forId.status == 'Done')
                    const SpinKitPulse(
                      size: 14,
                      color: Colors.green,
                    ),
                ],
              ),
            ),
          ],
        ),
        onTap: () {
          vm.loadForIdModel(forId);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ViewForId(
                        forIdModel: forId,
                      )));
        },
      ),
    );
  }
}


// 'Gathering Info',
 //   'Working',
  //  'Done',