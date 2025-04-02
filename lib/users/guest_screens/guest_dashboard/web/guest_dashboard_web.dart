import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:june/june.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_state.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:ssnhi_app/users/shared_screen/charts/maintenance_chart.dart';
import 'package:ssnhi_app/users/shared_screen/charts/monthly/monthly_summary_chart.dart';
import 'package:ssnhi_app/users/shared_screen/charts/performer_chart.dart';
import 'package:ssnhi_app/users/shared_screen/charts/request_per_department_chart.dart';
import 'package:ssnhi_app/users/guest_screens/for_id_guest/guest_for_id_card.dart';
import 'package:ssnhi_app/users/screens/authentication/sign%20in/sign_in.dart';
import 'package:universal_html/html.dart' as html;

class GuestDashboardWeb extends StatelessWidget {
  const GuestDashboardWeb({super.key});

  void _openInNewTab(String url) {
    html.window.open(url, 'new_tab');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: Column(
        children: [
          // AppBar-like header (outside scrollable content)
          Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              color: Colors.black87,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/brando_white.png'),
                ),
                const Text(
                  'Rêveur 🌙',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SigninPage()),
                    );
                  },
                  child: const Text(
                    'Sign In ✨',
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          // Main scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Column: Maintenance & Performer
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Maintenance Report',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      const SizedBox(
                                          height: 400,
                                          child: MaintenanceCategoryView()),
                                      const SizedBox(height: 12),
                                      Container(
                                        height: 60,
                                        padding: const EdgeInsets.all(12),
                                        decoration: const BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                              ),
                                              onPressed: () {
                                                showCupertinoModalPopup(
                                                    context: context,
                                                    builder: (context) =>
                                                        const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    50),
                                                            child:
                                                                PerformerChart()));
                                              },
                                              child: const Text(
                                                'Top Performers ❤️‍🔥',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  shadowColor: Colors.blue),
                                              onPressed: () {
                                                showCupertinoModalPopup(
                                                    context: context,
                                                    builder: (context) =>
                                                        const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    50),
                                                            child:
                                                                RequestPerDepartments()));
                                              },
                                              child: const Text(
                                                'Job Order by Department ✨',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            // ElevatedButton(
                                            //   style: ElevatedButton.styleFrom(
                                            //       backgroundColor: Colors.white,
                                            //       shadowColor: Colors.blue),
                                            //   onPressed: () {
                                            //     showModalBottomSheet(
                                            //         context: context,
                                            //         builder: (context) =>
                                            //             const MaterialUsedScreen());
                                            //   },
                                            //   child: const Text(
                                            //     'Materials Used ✨',
                                            //     style: TextStyle(
                                            //       fontSize: 18,
                                            //       fontWeight: FontWeight.w600,
                                            //       color: Colors.black,
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Center(
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: darkBackground,
                                            ),
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  20),
                                                          child:
                                                              MonthlySummaryScreen()));
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
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Right Column: For IDs & Requests
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'For IDs 💫',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: JuneBuilder(
                                          () => ForIdState(),
                                          builder: (forIdState) {
                                            return forIdState.isLoading
                                                ? const Center(
                                                    child: SpinKitFoldingCube(
                                                        color:
                                                            Colors.blueAccent),
                                                  )
                                                : forIdState.errorMessage !=
                                                        null
                                                    ? Center(
                                                        child: Text(
                                                            'Error: ${forIdState.errorMessage}'))
                                                    : forIdState
                                                            .forIdList.isEmpty
                                                        ? const Center(
                                                            child: Text(
                                                                'No records found'))
                                                        : ListView.builder(
                                                            itemCount:
                                                                forIdState
                                                                    .forIdList
                                                                    .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              final forId =
                                                                  forIdState
                                                                          .forIdList[
                                                                      index];
                                                              return GuestForIdCard(
                                                                  forId: forId,
                                                                  vm: forIdState);
                                                            },
                                                          );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Footer (sticks to bottom)
          Container(
            height: 60,
            padding: const EdgeInsets.all(20),
            color: Colors.black87,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Copyright © 2025. Brando, All Rights Reserved. Buy my art(?) here: ',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                TextButton(
                  onPressed: () {
                    _openInNewTab(
                        'https://echow.xyz/user/0xa5e2460c562438a47f385322b8e1108A4DC788a9');
                  },
                  child: const Text(
                    'Echow.xyz 🌙',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
