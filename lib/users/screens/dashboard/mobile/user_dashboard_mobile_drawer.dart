import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:june/june.dart';
import 'package:ssnhi_app/data/user/state/auth_state_june.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:ssnhi_app/users/screens/for_id/for_id_screen.dart';

// import 'package:ssnhi_app/users/screens/dashboard/state/dashboard_state.dart';

class UserDashboardMobileDrawer extends StatelessWidget {
  const UserDashboardMobileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    //
    final authState = June.getState(() => AuthState());
    // final webState = June.getState(() => DashboardState());
    //

    //

    //

    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/moon.jpg',
                  ),
                  fit: BoxFit.fill),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  minRadius: 50,
                  backgroundColor: Colors.white,
                  child: Text(
                    authState.user!.name[0],
                    style: const TextStyle(fontSize: 50, color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  authState.user!.name,
                  style: titleStyle,
                )
              ],
            ),
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.computer),
            contentPadding: const EdgeInsets.all(15),
            title: const Text(
              'IT Report ',
              style: titleStyle,
            ),
            onTap: () {
              // webState.showMoonForItReport();
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (_) => const ItReport()));
            },
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.idBadge),
            contentPadding: const EdgeInsets.all(15),
            title: const Text(
              'For ID',
              style: titleStyle,
            ),
            onTap: () {
              // webState.showMoonForId();
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const ForId()));
            },
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.toolbox),
            contentPadding: const EdgeInsets.all(15),
            title: const Text(
              'Maintenance Job Order',
              style: titleStyle,
            ),
            onTap: () {
              // webState.showMoonForJo();
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (_) => const MaintenanceJo()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            contentPadding: const EdgeInsets.all(15),
            title: const Text(
              'Log out',
              style: titleStyle,
            ),
            onTap: () async {
              await authState.userLogOut(context);
            },
          ),
        ],
      ),
    );
  }
}
