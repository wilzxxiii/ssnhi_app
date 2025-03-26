import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ssnhi_app/users/shared_screen/charts/maintenance_chart.dart';
import 'package:ssnhi_app/users/shared_screen/charts/monthly/monthly_summary_chart.dart';
import 'package:ssnhi_app/users/shared_screen/charts/performer_chart.dart';
import 'package:ssnhi_app/users/shared_screen/charts/request_per_department_chart.dart';
import 'package:ssnhi_app/users/guest_screens/for_id_guest/guest_for_id.dart';
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
      backgroundColor: Colors.blueGrey[100],
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
          'Rêveur 🌙',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      elevation: 10,
                      shadowColor: Colors.blue[700],
                      borderOnForeground: true,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Maintenance Report",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const SizedBox(
                                height: 400, child: MaintenanceCategoryView()),
                            const SizedBox(height: 12),
                            Card(
                              elevation: 10,
                              color: darkBackground,
                              child: ListTile(
                                hoverColor: Colors.blue,
                                minTileHeight: 70,
                                title: const Text(
                                  'Top Performers ❤️‍🔥',
                                  style: titleStyle,
                                ),
                                trailing: const Text(
                                  ' 💫',
                                  style: titleStyle,
                                ),
                                onTap: () {
                                  showCupertinoModalBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          const PerformerChart());
                                },
                              ),
                            ),
                            const SizedBox(height: 12),
                            Card(
                              elevation: 10,
                              color: darkBackground,
                              child: ListTile(
                                hoverColor: Colors.blue,
                                minTileHeight: 70,
                                title: const Text(
                                  'Request per Departments ✨',
                                  style: titleStyle,
                                ),
                                trailing: const Text(
                                  ' 💫',
                                  style: titleStyle,
                                ),
                                onTap: () {
                                  showCupertinoModalBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          const RequestPerDepartments());
                                },
                              ),
                            ),
                            const SizedBox(height: 12),
                            Center(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: darkBackground,
                                  ),
                                  onPressed: () {
                                    showCupertinoModalBottomSheet(
                                        context: context,
                                        builder: (context) =>
                                            const MonthlySummaryScreen());
                                  },
                                  child: const Text(
                                    'View by month 👀',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Card(
                    //   elevation: 10,
                    //   borderOnForeground: true,
                    //   shadowColor: Colors.blue[700],
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(16)),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(16.0),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         const Text(
                    //           "Top Performers ❤️‍🔥",
                    //           style: TextStyle(
                    //             fontSize: 20,
                    //             fontWeight: FontWeight.w600,
                    //             color: Colors.black87,
                    //           ),
                    //         ),
                    //         const SizedBox(height: 12),
                    //         const SizedBox(height: 500, child: PerformerChart()),
                    //         const SizedBox(height: 12),
                    //         Center(
                    //           child: ElevatedButton(
                    //               style: ElevatedButton.styleFrom(
                    //                 backgroundColor: Colors.black87,
                    //                 shape: RoundedRectangleBorder(
                    //                     borderRadius: BorderRadius.circular(12)),
                    //                 padding: const EdgeInsets.symmetric(
                    //                     horizontal: 20, vertical: 10),
                    //               ),
                    //               onPressed: () {},
                    //               child: const Text(
                    //                 'View all 👀',
                    //                 style: TextStyle(
                    //                     color: Colors.white, fontSize: 12),
                    //               )),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Card(
                    //   elevation: 10,
                    //   borderOnForeground: true,
                    //   shadowColor: Colors.blue[700],
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(16)),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(16.0),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         const Text(
                    //           "Request per Departments",
                    //           style: TextStyle(
                    //             fontSize: 20,
                    //             fontWeight: FontWeight.w600,
                    //             color: Colors.black87,
                    //           ),
                    //         ),
                    //         const SizedBox(height: 12),
                    //         const SizedBox(
                    //             height: 500, child: RequestPerDepartments()),
                    //         const SizedBox(height: 12),
                    //         Center(
                    //           child: ElevatedButton(
                    //               style: ElevatedButton.styleFrom(
                    //                 backgroundColor: Colors.black87,
                    //                 shape: RoundedRectangleBorder(
                    //                     borderRadius: BorderRadius.circular(12)),
                    //                 padding: const EdgeInsets.symmetric(
                    //                     horizontal: 20, vertical: 10),
                    //               ),
                    //               onPressed: () {
                    //                 showBarModalBottomSheet(
                    //                     context: context,
                    //                     builder: (context) => const Padding(
                    //                           padding: EdgeInsets.only(top: 15),
                    //                           child: RequestPerDepartments(),
                    //                         ));
                    //               },
                    //               child: const Text(
                    //                 'View all 👀',
                    //                 style: TextStyle(
                    //                     color: Colors.white, fontSize: 12),
                    //               )),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    //For ID
                    Card(
                      elevation: 10,
                      color: darkBackground,
                      child: ListTile(
                        hoverColor: Colors.blue,
                        minTileHeight: 100,
                        title: const Text(
                          'For ID\'s ✨',
                          style: titleStyle,
                        ),
                        trailing: const Text(
                          ' 💫',
                          style: titleStyle,
                        ),
                        subtitle: const Text(
                          'List of for ID\'s',
                          style: subtitleText,
                        ),
                        onTap: () {
                          showCupertinoModalBottomSheet(
                              context: context,
                              builder: (context) => const GuestForID());
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
            // width: double.infinity,
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
    );
  }
}
