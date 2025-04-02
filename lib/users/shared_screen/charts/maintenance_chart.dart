import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:june/state_manager/state_manager.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:ssnhi_app/shared/utils/responsive.dart';
import 'package:ssnhi_app/users/shared_screen/charts/state/maintenance_chart_state.dart';

class MaintenanceCategoryView extends StatelessWidget {
  const MaintenanceCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return JuneBuilder(() => MaintenanceChartState(),
        builder: (maintenanceChartState) {
      return SizedBox(
        child: Column(
          children: [
            const Text(
              'Summary of Job Order per Category 💫',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold), // Replace titleStyleDark
            ),
            const SizedBox(height: 10),
            maintenanceChartState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : maintenanceChartState.sheetData.isEmpty
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
                                      // setState(() {
                                      if (!event.isInterestedForInteractions ||
                                          pieTouchResponse == null ||
                                          pieTouchResponse.touchedSection ==
                                              null) {
                                        maintenanceChartState.touchedIndex = -1;
                                        return;
                                      }
                                      maintenanceChartState.touchedIndex =
                                          pieTouchResponse.touchedSection!
                                              .touchedSectionIndex;

                                      if (event is FlTapUpEvent) {
                                        final categoryName =
                                            maintenanceChartState
                                                    .categoryCounts.keys
                                                    .toList()[
                                                maintenanceChartState
                                                    .touchedIndex];
                                        if (Responsive.isMobile(context) ==
                                            true) {
                                          showCupertinoModalBottomSheet(
                                            context: context,
                                            builder: (context) =>
                                                CategoryDetailsScreen(
                                              categoryName: categoryName,
                                              sheetData: maintenanceChartState
                                                  .sheetData,
                                            ),
                                          );
                                        } else {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) =>
                                                CategoryDetailsScreen(
                                              categoryName: categoryName,
                                              sheetData: maintenanceChartState
                                                  .sheetData,
                                            ),
                                          );
                                        }
                                      }
                                      maintenanceChartState.setState();
                                      // });
                                    },
                                  ),
                                  sections: maintenanceChartState
                                      .categoryCounts.entries
                                      .map((entry) {
                                    final isTouched = maintenanceChartState
                                            .categoryCounts.keys
                                            .toList()
                                            .indexOf(entry.key) ==
                                        maintenanceChartState.touchedIndex;
                                    final fontSize = isTouched ? 16.0 : 14.0;
                                    final radius = isTouched ? 110.0 : 100.0;

                                    return PieChartSectionData(
                                      value: entry.value.toDouble(),
                                      title: '${entry.key}\n${entry.value}',
                                      color: Colors.accents[
                                          maintenanceChartState
                                                  .categoryCounts.keys
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
                            ),
                          ],
                        ),
                      ),
          ],
        ),
      );
    });
  }
}

class CategoryDetailsScreen extends StatefulWidget {
  final String categoryName;
  final List<Map<String, dynamic>> sheetData;

  const CategoryDetailsScreen({
    super.key,
    required this.categoryName,
    required this.sheetData,
  });

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  String searchQuery = ''; // To store the search input

  @override
  Widget build(BuildContext context) {
    // Filter sheetData for the selected category and search query
    final performerTasks = widget.sheetData
        .where((row) => row['Category'].toString() == widget.categoryName)
        .where((row) =>
            searchQuery.isEmpty ||
            row['Job Order #']
                    ?.toString()
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase()) ==
                true)
        .toList();

    const titleStyle = TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.categoryName} Job Orders 💖', style: titleStyle),
        backgroundColor: darkBackground,
        toolbarHeight: appBarHeight,
        leading: IconButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const FaIcon(Icons.close_rounded),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Box
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                textInputAction: TextInputAction.search,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Search Job Order #',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
            Expanded(
              child: performerTasks.isNotEmpty
                  ? ListView.builder(
                      itemCount: performerTasks.length,
                      itemBuilder: (context, index) {
                        final job = performerTasks[index];
                        return Card(
                          color: Colors.black,
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ExpansionTile(
                            iconColor: Colors.white,
                            collapsedIconColor: Colors.blue[300],
                            title: Text(
                              'Job Order ${job['Job Order #']} ✨',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            subtitle: Text(
                              'Performer: ${job['Performer'] ?? 'N/A'}',
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white),
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: job.entries.map((entry) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${entry.key}: ',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(
                                            child: Text(
                                              entry.value?.toString() ?? 'N/A',
                                              softWrap: true,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : const Center(child: Text('No matching job orders found')),
            ),
          ],
        ),
      ),
    );
  }
}
