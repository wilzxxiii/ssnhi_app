import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ssnhi_app/data/google_sheet.dart';

import 'package:ssnhi_app/guest/charts/monthly/monthly_category_chart.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:ssnhi_app/shared/utils/responsive.dart';

class MonthlySummaryScreen extends StatefulWidget {
  const MonthlySummaryScreen({super.key});

  @override
  State<MonthlySummaryScreen> createState() => _MonthlySummaryScreenState();
}

class _MonthlySummaryScreenState extends State<MonthlySummaryScreen> {
  List<Map<String, dynamic>> sheetData = [];
  bool isLoading = true;
  String? selectedMonth;
  int? selectedYear;
  int touchedIndex = -1;

  Map<String, int> categoryCount = {};
  Map<String, int> performerCount = {};
  Map<String, Map<String, int>> workRequestedCount = {};
  final List<String> categories = [
    "Aircon",
    "General Maintenance",
    "Electrical",
    "Plumbing"
  ];

  final List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  final List<int> years =
      List.generate(2, (index) => DateTime.now().year + index);

  final String sheetUrl = sheetsUrl; // From google_sheet.dart

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(sheetUrl));
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var values = json['values'] as List;
        if (values.isEmpty) {
          setState(() => isLoading = false);
          return;
        }

        var headers = values[0];
        var dataRows = values.sublist(1);

        sheetData = dataRows.map((row) {
          var rowMap = <String, dynamic>{};
          for (int i = 0; i < headers.length && i < row.length; i++) {
            rowMap[headers[i]] = row[i];
          }
          return rowMap;
        }).toList();

        setState(() {
          isLoading = false;
        });
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text('Failed to fetch data')),
        // );
        setState(() => isLoading = false);
      }
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Error: $e')),
      // );
      setState(() => isLoading = false);
    }
  }

  void filterData() {
    if (selectedMonth == null || selectedYear == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a month and year')),
      );
      return;
    }

    final monthMap = {
      "January": 1,
      "February": 2,
      "March": 3,
      "April": 4,
      "May": 5,
      "June": 6,
      "July": 7,
      "August": 8,
      "September": 9,
      "October": 10,
      "November": 11,
      "December": 12
    };
    final monthNum = monthMap[selectedMonth!];

    // Reset counts
    categoryCount.clear();
    performerCount.clear();
    workRequestedCount.clear();

    for (var row in sheetData) {
      var dateStr = row['Date Finished']?.toString() ?? '';
      if (dateStr.isEmpty) continue;

      try {
        var date = DateFormat('MM/dd/yyyy').parse(dateStr, true);
        if (date.month == monthNum && date.year == selectedYear!) {
          // Category Count
          var category = row['Category']?.toString() ?? 'Uncategorized';
          categoryCount[category] = (categoryCount[category] ?? 0) + 1;

          // Performer Count
          var performer = row['Performer']?.toString() ?? 'Unspecified';
          performerCount[performer] = (performerCount[performer] ?? 0) + 1;

          // Work Requested Count per Category
          if (categories.contains(category)) {
            var workRequested =
                row['Work Requested']?.toString() ?? 'Unspecified';
            workRequestedCount[category] ??= {};
            workRequestedCount[category]![workRequested] =
                (workRequestedCount[category]![workRequested] ?? 0) + 1;
          }
        }
      } catch (e) {
        debugPrint('Error parsing date "$dateStr": $e');
        continue;
      }
    }

    setState(() {}); // Trigger UI update
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text(
          'Monthly Job Order Summary 🔥',
          style: titleStyle,
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const FaIcon(Icons.arrow_back_ios_new),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // Month and Year Dropdowns
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownButton<String>(
                      hint: const Text('Select Month'),
                      value: selectedMonth,
                      items: months.map((month) {
                        return DropdownMenuItem<String>(
                          value: month,
                          child: Text(month),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedMonth = value;
                        });
                      },
                    ),
                    DropdownButton<int>(
                      hint: const Text('Select Year'),
                      value: selectedYear,
                      items: years.map((year) {
                        return DropdownMenuItem<int>(
                          value: year,
                          child: Text(year.toString()),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedYear = value;
                        });
                      },
                    ),
                    SizedBox(
                      child: OutlinedButton(
                        onPressed: filterData,
                        child: const Text(
                          'Filter Data',
                          style: titleStyleDark,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Category Pie Chart
                if (categoryCount.isNotEmpty)
                  SizedBox(
                    height: 300,
                    width: 300,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                touchedIndex = -1;
                                return;
                              }
                              touchedIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;

                              if (event is FlTapUpEvent) {
                                final categoryName =
                                    categoryCount.keys.toList()[touchedIndex];
                                if (Responsive.isMobile(context) == true) {
                                  showCupertinoModalBottomSheet(
                                    context: context,
                                    builder: (context) =>
                                        MonthlyCategoryDetailsScreen(
                                      categoryName: categoryName,
                                      sheetData: sheetData,
                                      selectedMonth: selectedMonth,
                                      selectedYear: selectedYear,
                                    ),
                                  );
                                } else {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) =>
                                        MonthlyCategoryDetailsScreen(
                                      categoryName: categoryName,
                                      sheetData: sheetData,
                                      selectedMonth: selectedMonth,
                                      selectedYear: selectedYear,
                                    ),
                                  );
                                }
                              }
                            });
                          },
                        ),
                        sections: categoryCount.entries.map((entry) {
                          final isTouched =
                              categoryCount.keys.toList().indexOf(entry.key) ==
                                  touchedIndex;
                          final fontSize = isTouched ? 14.0 : 12.0;
                          final radius = isTouched ? 110.0 : 100.0;

                          return PieChartSectionData(
                            value: entry.value.toDouble(),
                            title: '${entry.key}\n${entry.value}',
                            color: Colors.accents[
                                categoryCount.keys.toList().indexOf(entry.key) %
                                    Colors.accents.length],
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
                  )
                else
                  const Text('No category data for selected period'),

                const SizedBox(height: 16),
                const Text(
                  'Maintenance Staff # of works done ✨',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                // Performer Bar Chart
                if (performerCount.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    width:
                        double.infinity, // Ensures the table takes full width
                    child: DataTable(
                      columns: const [
                        DataColumn(
                          label: Text(
                            'Maintenance Staff',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Count',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                      rows: performerCount.entries.map((entry) {
                        return DataRow(
                          cells: [
                            DataCell(Text(
                              entry.key,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            )),
                            DataCell(Text(
                              entry.value.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            )),
                          ],
                        );
                      }).toList(),
                      border: TableBorder.all(
                          color: Colors.grey), // Optional: adds borders
                      columnSpacing: 20, // Adjust spacing between columns
                      // Adjust row height if needed
                    ),
                  )
                //if emptyviovdpfifb
                else
                  const Text('No performer data for the selected period'),

                const SizedBox(height: 16),

                // Work Requested Pie Charts
                ...categories.map((cat) {
                  final data = workRequestedCount[cat] ?? {};
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Work Requested for $cat ✨',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (data.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.all(30),
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          width: double
                              .infinity, // Ensures the table takes full width
                          child: DataTable(
                            columns: const [
                              DataColumn(
                                label: Text(
                                  'Problem',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Count',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                            rows: [
                              // Rows for each work requested item
                              ...data.entries.map((entry) {
                                return DataRow(
                                  cells: [
                                    DataCell(Text(
                                      entry.key,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    )),
                                    DataCell(Text(
                                      entry.value.toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    )),
                                  ],
                                );
                              }),
                              // Total row
                              DataRow(
                                cells: [
                                  const DataCell(Text(
                                    'Total',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                  DataCell(Text(
                                    data.values
                                        .reduce((a, b) => a + b)
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ],
                              ),
                            ],
                            border: TableBorder.all(
                                color: Colors.grey), // Optional: adds borders
                            columnSpacing: 20, // Adjust spacing between columns
                          ),
                        )
                      else
                        Text('No work requested data for $cat'),
                      const SizedBox(height: 16),
                    ],
                  );
                }),
              ],
            ),
    );
  }
}
