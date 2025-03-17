import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ssnhi_app/guest/charts/maintenance_chart.dart';
import 'package:ssnhi_app/guest/charts/monthly/monthly_summary_chart.dart';
import 'package:ssnhi_app/guest/charts/performer_chart.dart';
import 'package:ssnhi_app/guest/charts/request_per_department_chart.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

class GuestDashboardMaintenanceReportMobile extends StatelessWidget {
  const GuestDashboardMaintenanceReportMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.white,
          hoverColor: Colors.blue,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MonthlySummaryScreen()));
          },
          label: const Center(
            child: Text(
              'View by month ✨',
              style: titleStyleDark,
            ),
          )),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: iconColor),
        leading: IconButton(
          onPressed: () {
            // webState.showMoonDashboard();
            Navigator.pop(context);
          },
          icon: const FaIcon(Icons.arrow_back_ios_new),
        ),
        title: const Text(
          'Maintenance Job Order Report 💫',
          style: titleStyle,
        ),
        toolbarHeight: 80,
        elevation: 10,
        backgroundColor: mainColor,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              MaintenanceCategoryView(),
              SizedBox(
                height: 8,
              ),
              RequestPerDepartments(),
              SizedBox(
                height: 8,
              ),
              PerformerChart(),
            ],
          ),
        ),
      ),
    );
  }
}
