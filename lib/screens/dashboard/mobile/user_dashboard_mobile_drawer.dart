import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

class UserDashboardMobileDrawer extends StatelessWidget {
  const UserDashboardMobileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            color: Colors.white,
          ),
          const ListTile(
            leading: FaIcon(FontAwesomeIcons.barcode),
            contentPadding: EdgeInsets.all(15),
            title: Text(
              'Barcode',
              style: titleStyle,
            ),
          ),
          const ListTile(
            leading: Icon(Icons.note),
            contentPadding: EdgeInsets.all(15),
            title: Text(
              'Notebook',
              style: titleStyle,
            ),
          ),
          const ListTile(
            leading: Icon(Icons.logout),
            contentPadding: EdgeInsets.all(15),
            title: Text(
              'Log out',
              style: titleStyle,
            ),
          ),
        ],
      ),
    );
  }
}
