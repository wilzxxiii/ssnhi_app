import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:ssnhi_app/data/google_sheet.dart';

import 'package:ssnhi_app/shared/constants/constants.dart';

class GuestDashboardMaintenanceReportMobile extends StatelessWidget {
  const GuestDashboardMaintenanceReportMobile({super.key});

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
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              MaintenanceCategoryView(),
              RequestPerDepartments(),
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
  int touchedIndex = -1;

  Future<void> fetchData() async {
    const url = sheetsUrl;

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var values = json['values'] as List;
        if (values.isEmpty) {
          setState(() => isLoading = false);
          return;
        }

        var headers = values[0];
        var dataRows = values.length > 1 ? values.sublist(1) : [];

        sheetData = dataRows.map((row) {
          var rowMap = <String, dynamic>{};
          for (int i = 0; i < headers.length && i < row.length; i++) {
            rowMap[headers[i]] = row[i];
          }
          return rowMap;
        }).toList();

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
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold), // Replace titleStyleDark
          ),
          const SizedBox(height: 10),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : sheetData.isEmpty
                  ? const Center(child: Text('No data found'))
                  : Center(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 300,
                            height: 300,
                            child: PieChart(
                              PieChartData(
                                pieTouchData: PieTouchData(
                                  touchCallback:
                                      (FlTouchEvent event, pieTouchResponse) {
                                    setState(() {
                                      if (!event.isInterestedForInteractions ||
                                          pieTouchResponse == null ||
                                          pieTouchResponse.touchedSection ==
                                              null) {
                                        touchedIndex = -1;
                                        return;
                                      }
                                      touchedIndex = pieTouchResponse
                                          .touchedSection!.touchedSectionIndex;
                                    });
                                  },
                                ),
                                sections: categoryCounts.entries.map((entry) {
                                  final isTouched = categoryCounts.keys
                                          .toList()
                                          .indexOf(entry.key) ==
                                      touchedIndex;
                                  final fontSize = isTouched ? 16.0 : 14.0;
                                  final radius = isTouched ? 110.0 : 100.0;

                                  return PieChartSectionData(
                                    value: entry.value.toDouble(),
                                    title: '${entry.key}\n${entry.value}',
                                    color: Colors.primaries[categoryCounts.keys
                                            .toList()
                                            .indexOf(entry.key) %
                                        Colors.primaries.length],
                                    radius: radius,
                                    titleStyle: TextStyle(
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  );
                                }).toList(),
                                sectionsSpace: 2,
                                centerSpaceRadius: 40,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Display additional info when a section is touched
                          touchedIndex != -1
                              ? Text(
                                  'Selected: ${categoryCounts.keys.toList()[touchedIndex]} - ${categoryCounts.values.toList()[touchedIndex]} items',
                                  style: const TextStyle(fontSize: 16),
                                )
                              : const Text('Hover a section to see details'),
                        ],
                      ),
                    ),
        ],
      ),
    );
  }
}

class RequestPerDepartments extends StatefulWidget {
  const RequestPerDepartments({
    super.key,
  });

  @override
  State<RequestPerDepartments> createState() => _RequestPerDepartments();
}

class _RequestPerDepartments extends State<RequestPerDepartments> {
  List<Map<String, dynamic>> sheetData = [];
  Map<String, int> categoryCounts = {};
  bool isLoading = true;
  int touchedIndex = -1;

  Future<void> fetchData() async {
    const url = sheetsUrl;

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var values = json['values'] as List;
        if (values.isEmpty) {
          setState(() => isLoading = false);
          return;
        }

        var headers = values[0];
        var dataRows = values.length > 1 ? values.sublist(1) : [];

        sheetData = dataRows.map((row) {
          var rowMap = <String, dynamic>{};
          for (int i = 0; i < headers.length && i < row.length; i++) {
            rowMap[headers[i]] = row[i];
          }
          return rowMap;
        }).toList();

        categoryCounts.clear();
        for (var row in sheetData) {
          String category = row['Performer'].toString();
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
            'Request per Departments',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold), // Replace titleStyleDark
          ),
          const SizedBox(height: 10),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : sheetData.isEmpty
                  ? const Center(child: Text('No data found'))
                  : Column(
                      children: [
                        SizedBox(
                          width: 300,
                          height: 300,
                          child: PieChart(
                            PieChartData(
                              pieTouchData: PieTouchData(
                                touchCallback:
                                    (FlTouchEvent event, pieTouchResponse) {
                                  setState(() {
                                    if (!event.isInterestedForInteractions ||
                                        pieTouchResponse == null ||
                                        pieTouchResponse.touchedSection ==
                                            null) {
                                      touchedIndex = -1;
                                      return;
                                    }
                                    touchedIndex = pieTouchResponse
                                        .touchedSection!.touchedSectionIndex;
                                  });
                                },
                              ),
                              sections: categoryCounts.entries.map((entry) {
                                final isTouched = categoryCounts.keys
                                        .toList()
                                        .indexOf(entry.key) ==
                                    touchedIndex;
                                final fontSize = isTouched ? 16.0 : 14.0;
                                final radius = isTouched ? 110.0 : 100.0;

                                return PieChartSectionData(
                                  value: entry.value.toDouble(),
                                  title: '${entry.key}\n${entry.value}',
                                  color: Colors.primaries[categoryCounts.keys
                                          .toList()
                                          .indexOf(entry.key) %
                                      Colors.primaries.length],
                                  radius: radius,
                                  titleStyle: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                );
                              }).toList(),
                              sectionsSpace: 2,
                              centerSpaceRadius: 40,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Display additional info when a section is touched
                        touchedIndex != -1
                            ? Text(
                                '${categoryCounts.keys.toList()[touchedIndex]} - ${categoryCounts.values.toList()[touchedIndex]} performed Task',
                                style: const TextStyle(fontSize: 16),
                              )
                            : const Text('Hover a section to see details'),
                      ],
                    ),
        ],
      ),
    );
  }
}
