import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:june/june.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ssnhi_app/data/user/state/auth_state_june.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

import 'package:ssnhi_app/users/screens/for_id/for_id_screen.dart';
import 'package:ssnhi_app/users/shared_screen/charts/maintenance_chart.dart';
import 'package:ssnhi_app/users/shared_screen/charts/monthly/monthly_summary_chart.dart';
import 'package:ssnhi_app/users/shared_screen/charts/performer_chart.dart';
import 'package:ssnhi_app/users/shared_screen/charts/request_per_department_chart.dart';

class UserDashboardMobileView extends StatelessWidget {
  const UserDashboardMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = June.getState(() => AuthState());
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => const ChatAgentSreen()));
      //   },
      //   backgroundColor: mainColor,
      //   child: const Icon(
      //     Icons.chat,
      //     color: Colors.white,
      //   ),
      // ),
      // drawer: const UserDashboardMobileDrawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: iconColor),
        title: Text(
          'Welcome, ${authState.user!.name} ❤️‍🔥',
          style: titleStyle,
        ),
        toolbarHeight: appBarHeight,
        backgroundColor: darkBackground,
        actions: [
          IconButton(
              onPressed: () async {
                await authState.userLogOut(context);
              },
              icon: const FaIcon(Icons.logout_rounded)),
          const SizedBox(
            width: 10,
          )
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
                                height: 350, child: MaintenanceCategoryView()),
                            const SizedBox(height: 12),
                            Card(
                              elevation: 10,
                              color: darkBackground,
                              child: ListTile(
                                hoverColor: Colors.blue,
                                minTileHeight: listTileHeight,
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
                                minTileHeight: listTileHeight,
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

                    //For ID
                    Card(
                      elevation: 10,
                      color: darkBackground,
                      child: ListTile(
                        hoverColor: Colors.blue,
                        minTileHeight: 100,
                        title: const Text(
                          'For ID\'s ',
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
                              builder: (context) => const ForId());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
