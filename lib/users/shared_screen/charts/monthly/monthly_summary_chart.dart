import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fl_chart/fl_chart.dart';

import 'package:june/june.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:ssnhi_app/users/shared_screen/charts/monthly/monthly_category_chart.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:ssnhi_app/shared/utils/responsive.dart';
import 'package:ssnhi_app/users/shared_screen/charts/state/monthly_summary_chart_state.dart';

class MonthlySummaryScreen extends StatelessWidget {
  const MonthlySummaryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return JuneBuilder(() => MonthlySummaryChartState(),
        builder: (monthlySumState) {
      return Scaffold(
        backgroundColor: scaffoldColor,
        appBar: AppBar(
          toolbarHeight: appBarHeight,
          title: const Text(
            'Monthly Job Order Summary 🔥',
            style: titleStyle,
          ),
          backgroundColor: darkBackground,
          leading: IconButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const FaIcon(Icons.close_rounded),
          ),
        ),
        body: monthlySumState.isLoading
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
                        value: monthlySumState.selectedMonth,
                        items: monthlySumState.months.map((month) {
                          return DropdownMenuItem<String>(
                            value: month,
                            child: Text(month),
                          );
                        }).toList(),
                        onChanged: (value) {
                          monthlySumState.selectedMonth = value;
                          monthlySumState.setState();
                        },
                      ),
                      DropdownButton<int>(
                        hint: const Text('Select Year'),
                        value: monthlySumState.selectedYear,
                        items: monthlySumState.years.map((year) {
                          return DropdownMenuItem<int>(
                            value: year,
                            child: Text(year.toString()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          monthlySumState.selectedYear = value;
                          monthlySumState.setState();
                        },
                      ),
                      SizedBox(
                        child: OutlinedButton(
                          onPressed: monthlySumState.filterData,
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
                  if (monthlySumState.categoryCount.isNotEmpty)
                    SizedBox(
                      height: 300,
                      width: 300,
                      child: PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                monthlySumState.touchedIndex = -1;
                                return;
                              }
                              monthlySumState.touchedIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;

                              if (event is FlTapUpEvent) {
                                final categoryName = monthlySumState
                                    .categoryCount.keys
                                    .toList()[monthlySumState.touchedIndex];
                                if (Responsive.isMobile(context) == true) {
                                  showCupertinoModalBottomSheet(
                                    context: context,
                                    builder: (context) =>
                                        MonthlyCategoryDetailsScreen(
                                      categoryName: categoryName,
                                      sheetData: monthlySumState.sheetData,
                                      selectedMonth:
                                          monthlySumState.selectedMonth,
                                      selectedYear:
                                          monthlySumState.selectedYear,
                                    ),
                                  );
                                } else {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) =>
                                        MonthlyCategoryDetailsScreen(
                                      categoryName: categoryName,
                                      sheetData: monthlySumState.sheetData,
                                      selectedMonth:
                                          monthlySumState.selectedMonth,
                                      selectedYear:
                                          monthlySumState.selectedYear,
                                    ),
                                  );
                                }
                              }
                              monthlySumState.setState();
                            },
                          ),
                          sections: monthlySumState.categoryCount.entries
                              .map((entry) {
                            final isTouched = monthlySumState.categoryCount.keys
                                    .toList()
                                    .indexOf(entry.key) ==
                                monthlySumState.touchedIndex;
                            final fontSize = isTouched ? 14.0 : 12.0;
                            final radius = isTouched ? 110.0 : 100.0;

                            return PieChartSectionData(
                              value: entry.value.toDouble(),
                              title: '${entry.key}\n${entry.value}',
                              color: Colors.accents[monthlySumState
                                      .categoryCount.keys
                                      .toList()
                                      .indexOf(entry.key) %
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
                    'Maintenance Staff No. of works done ✨',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Performer Bar Chart
                  if (monthlySumState.performerCount.isNotEmpty)
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
                        rows:
                            monthlySumState.performerCount.entries.map((entry) {
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
                  ...monthlySumState.categories.map((cat) {
                    final data = monthlySumState.workRequestedCount[cat] ?? {};
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
                              columnSpacing:
                                  20, // Adjust spacing between columns
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
    });
  }
}
