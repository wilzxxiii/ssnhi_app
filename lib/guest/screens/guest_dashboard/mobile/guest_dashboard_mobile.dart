import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ssnhi_app/guest/maintenance/guest_dashboard_maintenance.dart';
// import 'package:june/june.dart';
// import 'package:ssnhi_app/data/user/state/auth_state_june.dart';
import 'package:ssnhi_app/users/screens/authentication/sign%20in/sign_in.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:ssnhi_app/users/screens/for_id/for_id_screen.dart';
import 'package:universal_html/html.dart' as html;

class GuestDashboarMobile extends StatelessWidget {
  const GuestDashboarMobile({super.key});

  void _openInNewTab(String url) {
    html.window.open(url,
        'https://echow.xyz/user/0xa5e2460c562438a47f385322b8e1108A4DC788a9');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        hoverColor: hoverColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SigninPage(),
            ),
          );
        },
        backgroundColor: mainColor,
        label: const Text(
          'Sign in ✨',
          style: titleStyle,
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: false,
        backgroundColor: lightBackground,
        title: const Text(
          'Believe in something, Brando.🌙',
          style: titleStyleDark,
        ),
        elevation: 5,
        shadowColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.orange,
                image: DecorationImage(
                    image: AssetImage('assets/brando_black.png'),
                    fit: BoxFit.contain),
              ),
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      //for maintenance view
                      Card(
                        color: darkBackground,
                        child: ListTile(
                          trailing: const SpinKitPumpingHeart(
                            color: Colors.white,
                            size: 15,
                          ),
                          leading: const FaIcon(
                            FontAwesomeIcons.toolbox,
                            color: Colors.white,
                          ),
                          minTileHeight: 100,
                          title: const Text(
                            'Maintenance  💫',
                            style: titleStyle,
                          ),
                          subtitle: const Text(
                            'Maintenance Reports',
                            style: subtitleText,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const GuestDashboardMaintenanceReports()));
                          },
                        ),
                      ),
                      //For ID
                      Card(
                        color: darkBackground,
                        child: ListTile(
                          trailing: const SpinKitPumpingHeart(
                            color: Colors.white,
                            size: 15,
                          ),
                          leading: const FaIcon(
                            FontAwesomeIcons.idBadge,
                            color: Colors.white,
                          ),
                          minTileHeight: 100,
                          title: const Text(
                            'For ID\'s 💫',
                            style: titleStyle,
                          ),
                          subtitle: const Text(
                            'List of for ID\'s',
                            style: subtitleText,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ForID()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Center(
                child: Column(
                  children: [
                    const Text(
                      'Copyright © 2025. Brando, All Rights Reserved. Support the dev by buying his art here: ',
                      style: titleStyle,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                          onPressed: () {
                            _openInNewTab(
                                'https://echow.xyz/user/0xa5e2460c562438a47f385322b8e1108A4DC788a9');
                          },
                          child: const Text(
                            'Echow.xyz',
                            style: titleStyle,
                          )),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
