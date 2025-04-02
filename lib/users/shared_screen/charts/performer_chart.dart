import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:june/state_manager/state_manager.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ssnhi_app/shared/utils/google_sheet.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
// import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:ssnhi_app/shared/utils/responsive.dart';
import 'package:ssnhi_app/users/shared_screen/charts/state/performer_chart_state.dart'; // For FaIcon

class PerformerChart extends StatelessWidget {
  const PerformerChart({super.key});

  @override
  Widget build(BuildContext context) {
    return JuneBuilder(() => PerformerChartState(), builder: (performerState) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: appBarHeight,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const FaIcon(
              Icons.close,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(5),
          child: performerState.isLoading
              ? const Center(child: CircularProgressIndicator())
              : performerState.sheetData.isEmpty
                  ? const Center(child: Text('No data found'))
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            const Center(
                              child: Text(
                                'Job Orders done by staff 💫',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Center(
                              child: Text(
                                'P.S. You can click their names 🤭',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            DataTable(
                              columns: const [
                                DataColumn(
                                  label: Text(
                                    'Maintenance Staff and Total Job Orders',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                              rows: () {
                                final sortedEntries =
                                    performerState.staffTotals.entries.toList();
                                sortedEntries
                                    .sort((a, b) => b.value.compareTo(a.value));
                                return sortedEntries.map((entry) {
                                  return DataRow(
                                    cells: [
                                      DataCell(
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap: () {
                                              if (Responsive.isMobile(
                                                  context)) {
                                                showCupertinoModalBottomSheet(
                                                  context: context,
                                                  builder: (context) =>
                                                      PerformerDetailsScreen(
                                                    performerName: entry.key,
                                                    entitiesData: performerState
                                                        .sheetData,
                                                  ),
                                                );
                                              } else {
                                                showModalBottomSheet(
                                                  context: context,
                                                  builder: (context) =>
                                                      PerformerDetailsScreen(
                                                    performerName: entry.key,
                                                    entitiesData: performerState
                                                        .sheetData,
                                                  ),
                                                );
                                              }
                                            },
                                            child: Text(
                                              "${entry.key} completed ${entry.value} job order${entry.value == 1 ? '' : 's'}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList();
                              }(),
                              columnSpacing: 20,
                              horizontalMargin: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
        ),
      );
    });
  }
}

class PerformerDetailsScreen extends StatefulWidget {
  final String performerName;
  final List<Map<String, dynamic>> entitiesData;

  const PerformerDetailsScreen({
    super.key,
    required this.performerName,
    required this.entitiesData,
  });

  @override
  State<PerformerDetailsScreen> createState() => _PerformerDetailsScreenState();
}

class _PerformerDetailsScreenState extends State<PerformerDetailsScreen> {
  String searchQuery = '';
  late Future<List<Map<String, dynamic>>> _jobOrderDetailsFuture;

  @override
  void initState() {
    super.initState();

    var staffData = widget.entitiesData.firstWhere(
      (row) => row['Staff Name'] == widget.performerName,
      orElse: () => {'Job Orders': ''},
    );
    var jobOrders = staffData['Job Orders']
            ?.toString()
            .split(", ")
            .where((jo) => jo.isNotEmpty)
            .toList() ??
        [];
    _jobOrderDetailsFuture = _fetchJobOrderDetails(jobOrders);
  }

  Future<List<Map<String, dynamic>>> _fetchJobOrderDetails(
      List<String> jobOrders) async {
    const url = sheetsUrl;
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var values = json['values'] as List;
        if (values.isEmpty) return [];

        var headers = values[0];
        var dataRows = values.length > 1 ? values.sublist(1) : [];

        var joData = dataRows.map((row) {
          var rowMap = <String, dynamic>{};
          for (int i = 0; i < headers.length && i < row.length; i++) {
            rowMap[headers[i]] = row[i];
          }
          return rowMap;
        }).toList();

        return joData.where((row) {
          return jobOrders.contains(row['Job Order #']);
        }).toList();
      }
    } catch (e) {
      // print('Error fetching JO Data: $e');
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('${widget.performerName} - Tasks Done 💖', style: titleStyle),
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
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _jobOrderDetailsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child:
                            Text('No job orders found for this staff member'));
                  }

                  // Filter tasks based on search query
                  final performerTasks = snapshot.data!.where((job) {
                    return searchQuery.isEmpty ||
                        job['Job Order #']
                                ?.toString()
                                .toLowerCase()
                                .contains(searchQuery.toLowerCase()) ==
                            true;
                  }).toList();

                  if (performerTasks.isEmpty) {
                    return const Center(
                        child: Text('No matching job orders found'));
                  }

                  return ListView.builder(
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
                            'Category: ${job['Category'] ?? 'N/A'}',
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
