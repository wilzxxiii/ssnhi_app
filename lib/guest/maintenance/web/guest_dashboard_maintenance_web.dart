import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:ssnhi_app/data/google_sheet.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

class GuestDashboardMaintenanceReportWeb extends StatelessWidget {
  const GuestDashboardMaintenanceReportWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Maintenance Reports 💫',
          style: titleStyle,
        ),
        toolbarHeight: 80,
        elevation: 10,
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const MaintenanceCategoryView(),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class MaintenanceCategoryView extends StatefulWidget {
  const MaintenanceCategoryView({
    super.key,
  });

  @override
  State<MaintenanceCategoryView> createState() =>
      _MaintenanceCategoryViewState();
}

class _MaintenanceCategoryViewState extends State<MaintenanceCategoryView> {
  List<Map<String, dynamic>> sheetData = [];
  Map<String, int> categoryCounts = {};
  bool isLoading = true;

  Future<void> fetchData() async {
    // const sheetId = "1v95m_vU2W8ZyxTg_NCYQcxMQniBqaBtxxbUTLOByS0I";
    // const apiKey = googleCloudApiKey; // Replace with your API key
    // const range =
    //     'JO Data!A3:N'; // Fetch A3:N (adjust last row dynamically if needed)
    const url = sheetsUrl;

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var values = json['values'] as List;
        if (values.isEmpty) {
          print('No values returned');
          setState(() => isLoading = false);
          return;
        }

        // Extract headers from A3:N3
        var headers = values[0];
        // Extract data rows from A4 onward
        var dataRows = values.length > 1 ? values.sublist(1) : [];

        // Map data rows to sheetData
        sheetData = dataRows.map((row) {
          var rowMap = <String, dynamic>{};
          for (int i = 0; i < headers.length && i < row.length; i++) {
            rowMap[headers[i]] = row[i];
          }
          return rowMap;
        }).toList();

        // Aggregate counts by CategoryJO
        categoryCounts.clear();
        for (var row in sheetData) {
          String category = row['Category'].toString();
          categoryCounts[category] = (categoryCounts[category] ?? 0) + 1;
        }

        setState(() {
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const Text(
            'Category',
            style: titleStyleDark,
          ),
          const SizedBox(
            height: 10,
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : sheetData.isEmpty
                  ? const Center(child: Text('No data found'))
                  : Center(
                      child: SizedBox(
                        // width: 300,
                        // height: 300,
                        child: PieChart(
                          PieChartData(
                            sections: categoryCounts.entries.map((entry) {
                              return PieChartSectionData(
                                value: entry.value.toDouble(),
                                title: entry.key,
                                color: Colors.primaries[categoryCounts.keys
                                        .toList()
                                        .indexOf(entry.key) %
                                    Colors.primaries.length],
                                radius: 100,
                                titleStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              );
                            }).toList(),
                            sectionsSpace: 2,
                            centerSpaceRadius: 40,
                          ),
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}
