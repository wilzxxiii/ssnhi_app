import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:june/june.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

import 'state/dashboard_state.dart';

class UserDashboardMenu extends StatelessWidget {
  const UserDashboardMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return JuneBuilder(() => DashboardState(), builder: (webState) {
      return Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Material(
              color: darkBackground,
              child: ListTile(
                contentPadding: const EdgeInsets.all(5),
                title: const Text(
                  'Dashboard',
                  style: titleStyle,
                ),
                trailing: Visibility(
                  visible: webState.moonDashboard,
                  child: const SpinKitPumpingHeart(
                    color: Colors.orange,
                    size: 20,
                  ),
                ),
                leading: const Icon(
                  Icons.dashboard,
                  color: Colors.white,
                  size: 15,
                ),
                hoverColor: Colors.orange,
                onTap: () {
                  webState.showMoonDashboard();
                },
              ),
            ),
            Material(
              color: darkBackground,
              child: ListTile(
                trailing: Visibility(
                  visible: webState.moonForId,
                  child: const SpinKitPumpingHeart(
                    color: Colors.orange,
                    size: 20,
                  ),
                ),
                contentPadding: const EdgeInsets.all(5),
                title: const Text(
                  'For ID\'s',
                  style: titleStyle,
                ),
                leading: const FaIcon(
                  FontAwesomeIcons.idBadge,
                  color: Colors.white,
                  size: 20,
                ),
                hoverColor: Colors.orange,
                onTap: () {
                  webState.showMoonForId();
                },
              ),
            ),
            Material(
              color: darkBackground,
              child: ListTile(
                trailing: Visibility(
                  visible: webState.moonForJo,
                  child: const SpinKitPumpingHeart(
                    color: Colors.orange,
                    size: 20,
                  ),
                ),
                leading: const FaIcon(
                  FontAwesomeIcons.toolbox,
                  color: Colors.white,
                  size: 15,
                ),
                contentPadding: const EdgeInsets.all(5),
                title: const Text(
                  'Maintenance Job Order',
                  style: titleStyle,
                ),
                hoverColor: Colors.orange,
                onTap: () {
                  webState.showMoonForJo();
                },
              ),
            ),
            Material(
              color: darkBackground,
              child: ListTile(
                trailing: Visibility(
                  visible: webState.moonForItreport,
                  child: const SpinKitPumpingHeart(
                    color: Colors.orange,
                    size: 20,
                  ),
                ),
                leading: const FaIcon(
                  FontAwesomeIcons.computer,
                  color: Colors.white,
                  size: 20,
                ),
                contentPadding: const EdgeInsets.all(5),
                title: const Text(
                  'IT Report ',
                  style: titleStyle,
                ),
                hoverColor: Colors.orange,
                onTap: () {
                  webState.showMoonForItReport();
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
