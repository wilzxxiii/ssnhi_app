import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ssnhi_app/data/google_sheet.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:ssnhi_app/shared/utils/responsive.dart'; // For FaIcon

class PerformerChart extends StatefulWidget {
  const PerformerChart({
    super.key,
  });

  @override
  State<PerformerChart> createState() => _PerformerChart();
}

class _PerformerChart extends State<PerformerChart> {
  List<Map<String, dynamic>> sheetData = [];
  Map<String, int> categoryCounts = {};
  bool isLoading = true;

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
    return Padding(
      padding: const EdgeInsets.all(5),
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : sheetData.isEmpty
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
                            'Job Orders done by staff',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        DataTable(
                          columns: const [
                            DataColumn(
                              label: Text(
                                'Maintenance Staff and the number of task/s done',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                          rows: () {
                            final sortedEntries =
                                categoryCounts.entries.toList();
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
                                          if (Responsive.isMobile(context) ==
                                              true) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PerformerDetailsScreen(
                                                  performerName: entry.key,
                                                  sheetData: sheetData,
                                                ),
                                              ),
                                            );
                                          } else {
                                            showCupertinoModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  PerformerDetailsScreen(
                                                performerName: entry.key,
                                                sheetData: sheetData,
                                              ),
                                            );
                                          }
                                        },
                                        child: Text(
                                          "${entry.key} did ${entry.value.toString()} task/s",
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // DataCell(
                                  //   MouseRegion(
                                  //     cursor: SystemMouseCursors.click,
                                  //     child: GestureDetector(
                                  //       onTap: () {
                                  //         Navigator.push(
                                  //           context,
                                  //           MaterialPageRoute(
                                  //             builder: (context) =>
                                  //                 PerformerDetailsScreen(
                                  //               performerName: entry.key,
                                  //               sheetData: sheetData,
                                  //             ),
                                  //           ),
                                  //         );
                                  //       },
                                  //       child: Text(
                                  //         entry.value.toString(),
                                  //         style: const TextStyle(
                                  //           color: Colors.white,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
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
    );
  }
}

// Updated Performer Details Screen with Clickable Rows
class PerformerDetailsScreen extends StatelessWidget {
  final String performerName;
  final List<Map<String, dynamic>> sheetData;

  const PerformerDetailsScreen({
    super.key,
    required this.performerName,
    required this.sheetData,
  });

  @override
  Widget build(BuildContext context) {
    // Filter sheetData for the selected performer
    final performerTasks = sheetData
        .where((row) => row['Performer'].toString() == performerName)
        .toList();

    // Define the headers we want to show
    const desiredHeaders = ['Job Order #', 'Category', 'Status'];

    // Assuming titleStyle is defined elsewhere; replace with your style if needed
    const titleStyle = TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('$performerName - Tasks Done 💖', style: titleStyle),
        backgroundColor: Colors.black,
        toolbarHeight: 80,
        leading: IconButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const FaIcon(Icons.arrow_back_ios_new),
        ),
      ),
      body: performerTasks.isEmpty
          ? const Center(child: Text('No tasks found for this performer'))
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: performerTasks.map((task) {
                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskDetailsScreen(
                                task: task,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.blueGrey,
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: desiredHeaders.map((header) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '$header: ',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          task[header]?.toString() ?? 'N/A',
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
    );
  }
}

// Task Details Screen
class TaskDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> task;

  const TaskDetailsScreen({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
            'Task Details - ${task['Job Order #'] + " 💖" ?? 'Unknown'}',
            style: titleStyle),
        backgroundColor: Colors.black,
        leading: IconButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const FaIcon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: task.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${entry.key}: ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        entry.value?.toString() ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
