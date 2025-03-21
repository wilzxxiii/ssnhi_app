import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:june/june.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_state.dart';
import 'package:ssnhi_app/data/user/state/auth_state_june.dart';
import 'package:ssnhi_app/users/screens/dashboard/charts/maintenance_chart.dart';
import 'package:ssnhi_app/users/screens/dashboard/charts/performer_chart.dart';
import 'package:ssnhi_app/users/screens/dashboard/charts/request_per_department_chart.dart';
import 'package:ssnhi_app/users/screens/dashboard/for_id/guest_for_id_card.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:ssnhi_app/users/screens/chat/chat_agent.dart';

class UserDashboardWebView extends StatelessWidget {
  const UserDashboardWebView({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = June.getState(() => AuthState());
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => Container(
                      decoration: const BoxDecoration(),
                      padding: const EdgeInsets.all(100),
                      child: const ChatAgentSreen(),
                    ));
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
          toolbarHeight: 80,
          elevation: 10,
          backgroundColor: mainColor,
        ),
        body: Container(
          color: Colors.white70,
          child: Column(
            children: [
              // Main scrollable content
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Dashboard Overview',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left Column: Maintenance & Performer
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  _buildCard(
                                    title: 'Maintenance Report',
                                    child: const MaintenanceCategoryView(),
                                    height: 400,
                                  ),
                                  const SizedBox(height: 16),
                                  _buildCard(
                                    title: 'Top Performers ❤️‍🔥',
                                    child: const PerformerChart(),
                                    height: 400,
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
                                  _buildCard(
                                    title: 'For IDs 💫',
                                    child: SizedBox(
                                      height: 450,
                                      child: JuneBuilder(
                                        () => ForIdState(),
                                        builder: (forIdState) {
                                          return forIdState.isLoading
                                              ? const Center(
                                                  child: SpinKitFoldingCube(
                                                      color: Colors.blueAccent),
                                                )
                                              : forIdState.errorMessage != null
                                                  ? Center(
                                                      child: Text(
                                                          'Error: ${forIdState.errorMessage}'))
                                                  : forIdState.forIdList.isEmpty
                                                      ? const Center(
                                                          child: Text(
                                                              'No records found'))
                                                      : ListView.builder(
                                                          itemCount: forIdState
                                                              .forIdList.length,
                                                          itemBuilder:
                                                              (context, index) {
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
                                  ),
                                  const SizedBox(height: 16),
                                  _buildCard(
                                    title: 'Requests per Department',
                                    child: const RequestPerDepartments(),
                                    height: 550,
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
              // Container(
              //   padding: const EdgeInsets.all(20),
              //   color: Colors.black87,
              //   width: double.infinity,
              //   child: const Text(
              //     'Copyright © 2025. Brando, All Rights Reserved. Buy my art(?) here: ',
              //     style: TextStyle(color: Colors.white, fontSize: 14),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildCard(
    {required String title, required Widget child, double? height}) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(height: height ?? 200, child: child),
        ],
      ),
    ),
  );
}
