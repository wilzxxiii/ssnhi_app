import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:june/june.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_state.dart';
import 'package:ssnhi_app/users/screens/dashboard/charts/maintenance_chart.dart';
import 'package:ssnhi_app/users/screens/dashboard/charts/monthly/monthly_summary_chart.dart';
import 'package:ssnhi_app/users/screens/dashboard/charts/performer_chart.dart';
import 'package:ssnhi_app/users/screens/dashboard/charts/request_per_department_chart.dart';
import 'package:ssnhi_app/users/screens/dashboard/for_id/guest_for_id_card.dart';
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
      backgroundColor: Colors.grey[100],
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        hoverColor: Colors.blue[700],
        onPressed: () {
          showDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) => const Padding(
              padding: EdgeInsets.all(100),
              child: MonthlySummaryScreen(),
            ),
          );
        },
        label: const Text(
          'Let\'s view it by month, shall we? 🤝',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: Colors.blue[700],
        child: Column(
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
                    'Believe in Something 🌙',
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
            Container(
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
      ),
    );
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
}
