import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ssnhi_app/users/screens/dashboard/charts/maintenance_chart.dart';
import 'package:ssnhi_app/users/screens/dashboard/charts/performer_chart.dart';
import 'package:ssnhi_app/users/screens/dashboard/charts/request_per_department_chart.dart';
import 'package:ssnhi_app/users/screens/dashboard/for_id/guest_for_id.dart';
import 'package:ssnhi_app/users/screens/authentication/sign%20in/sign_in.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
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
      // floatingActionButton: FloatingActionButton.extended(
      //   hoverColor: hoverColor,
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => const SigninPage(),
      //       ),
      //     );
      //   },
      //   backgroundColor: mainColor,
      //   label: const Text(
      //     'Sign in ✨',
      //     style: titleStyle,
      //   ),
      // ),
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: false,
        backgroundColor: Colors.black87,
        title: const Text(
          'Believe in something 🌙',
          style: titleStyle,
        ),
        automaticallyImplyLeading: false,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SigninPage()),
              );
            },
            child: const Text(
              'Sign In ✨',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  Card(
                    elevation: 4,
                    shadowColor: Colors.blue[700],
                    borderOnForeground: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Maintenance Report",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 12),
                          SizedBox(
                              height: 400, child: MaintenanceCategoryView()),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 4,
                    borderOnForeground: true,
                    shadowColor: Colors.blue[700],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Top Performers ❤️‍🔥",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const SizedBox(height: 500, child: PerformerChart()),
                          const SizedBox(height: 12),
                          Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black87,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  'View all 👀',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 4,
                    borderOnForeground: true,
                    shadowColor: Colors.blue[700],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Request per Departments",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const SizedBox(
                              height: 500, child: RequestPerDepartments()),
                          const SizedBox(height: 12),
                          Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black87,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                ),
                                onPressed: () {
                                  showBarModalBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          const RequestPerDepartments());
                                },
                                child: const Text(
                                  'View all 👀',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //for maintenance view
                  // Card(
                  //   color: darkBackground,
                  //   child: ListTile(
                  //     trailing: const SpinKitPumpingHeart(
                  //       color: Colors.white,
                  //       size: 15,
                  //     ),
                  //     leading: const FaIcon(
                  //       FontAwesomeIcons.toolbox,
                  //       color: Colors.white,
                  //     ),
                  //     minTileHeight: 100,
                  //     title: const Text(
                  //       'Maintenance  💫',
                  //       style: titleStyle,
                  //     ),
                  //     subtitle: const Text(
                  //       'Maintenance Reports',
                  //       style: subtitleText,
                  //     ),
                  //     onTap: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) =>
                  //                   const GuestDashboardMaintenanceReports()));
                  //     },
                  //   ),
                  // ),
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
                        showBarModalBottomSheet(
                            context: context,
                            builder: (context) => const GuestForID());
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              color: Colors.black87,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Copyright © 2025. Brando, All Rights Reserved. Buy my art(?) here: ',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child:
                    // )
                    Center(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.black, //<-- SEE HERE
                          elevation: 10,
                        ),
                        onPressed: () {
                          _openInNewTab(
                              'https://echow.xyz/user/0xa5e2460c562438a47f385322b8e1108A4DC788a9');
                        },
                        child: const Text(
                          'Echow.xyz 🌙',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
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
