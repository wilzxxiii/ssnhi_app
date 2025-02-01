import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:june/june.dart';
import 'package:ssnhi_app/data/user/auth/user_firebase.dart';
import 'package:ssnhi_app/data/user/state/auth_state_june.dart';
import 'package:ssnhi_app/screens/for%20id/for_id_screen.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

class UserDashboardMobileDrawer extends StatelessWidget {
  const UserDashboardMobileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    //
    final authState = June.getState(() => AuthState());
    //
    final AuthService authService = AuthService();
    //

    //
    Future<void> logOutDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Are you sure you want to log out cutie? 🌙'),
            content: const SingleChildScrollView(
                // child: ListBody(
                //   children: <Widget>[

                //     Text('Would you like to approve of this message?'),
                //   ],
                // ),
                ),
            actions: <Widget>[
              TextButton(
                child: const Text('Yes'),
                onPressed: () async {
                  await authService.logOut();
                },
              ),
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  minRadius: 50,
                  backgroundColor: Colors.black,
                  child: Text(
                    authState.user!.name[0],
                    style: const TextStyle(fontSize: 50, color: Colors.white),
                  ),
                ),
                Text(authState.user!.name)
              ],
            ),
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.idBadge),
            contentPadding: const EdgeInsets.all(15),
            title: const Text(
              'For ID',
              style: titleStyle,
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const ForID()));
            },
          ),
          const ListTile(
            leading: Icon(Icons.note),
            contentPadding: EdgeInsets.all(15),
            title: Text(
              'Notebook (Coming soon)',
              style: titleStyle,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            contentPadding: const EdgeInsets.all(15),
            title: const Text(
              'Log out',
              style: titleStyle,
            ),
            onTap: () async {
              await logOutDialog();
            },
          ),
        ],
      ),
    );
  }
}
