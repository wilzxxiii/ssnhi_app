import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:june/june.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_state.dart';
import 'package:ssnhi_app/data/user/state/auth_state_june.dart';
import 'package:ssnhi_app/users/screens/for_id/add_for_id/add_for_id.dart';
import 'package:ssnhi_app/users/screens/for_id/for_id_card.dart';
import 'package:ssnhi_app/users/shared_screen/charts/maintenance_chart.dart';
import 'package:ssnhi_app/users/shared_screen/charts/monthly/monthly_summary_chart.dart';
import 'package:ssnhi_app/users/shared_screen/charts/performer_chart.dart';
import 'package:ssnhi_app/users/shared_screen/charts/request_per_department_chart.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

class UserDashboardWebView extends StatelessWidget {
  const UserDashboardWebView({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = June.getState(() => AuthState());
    return SafeArea(
      child: Scaffold(
        backgroundColor: scaffoldColor,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // showDialog(
            //     context: context,
            //     builder: (context) => Container(
            //           decoration: const BoxDecoration(),
            //           padding: const EdgeInsets.all(100),
            //           child: const ChatAgentSreen(),
            //         ));
          },
          backgroundColor: Colors.blueGrey[600],
          hoverColor: hoverColor,
          tooltip: 'Chat with AI',
          label: const Text(
            'Chat with AI ✨',
            style: titleStyle,
          ),
          // child: const Icon(
          //   Icons.chat,
          //   color: Colors.white,
          // ),
        ),
        // drawer: const UserDashboardMobileDrawer(),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: iconColor),
          title: Text(
            'Welcome, ${authState.user!.name} ❤️‍🔥',
            style: titleStyle,
          ),
          automaticallyImplyLeading: false,
          toolbarHeight: appBarHeight,
          backgroundColor: darkBackground,
          actions: [
            IconButton(
                onPressed: () async {
                  await authState.userLogOut(context);
                },
                icon: const FaIcon(Icons.logout_rounded)),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: Column(
          children: [
            // Main scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Text(
                      //   'Dashboard Overview',
                      //   style: TextStyle(
                      //     fontSize: 28,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.black87,
                      //   ),
                      // ),
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
                                          width:
                                              MediaQuery.of(context).size.width,
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
                                                  showModalBottomSheet(
                                                      context: context,
                                                      builder: (context) =>
                                                          const PerformerChart());
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
                                                    backgroundColor:
                                                        Colors.white,
                                                    shadowColor: Colors.blue),
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                      context: context,
                                                      builder: (context) =>
                                                          const RequestPerDepartments());
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
                            child: JuneBuilder(
                              () => ForIdState(),
                              builder: (forIdState) {
                                return Column(
                                  children: [
                                    Card(
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'For IDs 💫',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          darkBackground,
                                                    ),
                                                    onPressed: () {
                                                      showModalBottomSheet(
                                                          context: context,
                                                          builder: (context) =>
                                                              AddForId(
                                                                vm: forIdState,
                                                              ));
                                                    },
                                                    child: const Text(
                                                      'Add Record',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                            const SizedBox(height: 12),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              child: forIdState.isLoading
                                                  ? const Center(
                                                      child: SpinKitFoldingCube(
                                                          color: Colors
                                                              .blueAccent),
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
                                                                return ForIdCard(
                                                                    forId:
                                                                        forId,
                                                                    vm: forIdState);
                                                              },
                                                            ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
