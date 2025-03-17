import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ssnhi_app/data/google_sheet.dart';
import 'package:ssnhi_app/shared/utils/responsive.dart';

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
            'Summary of Job Order per Category 💫',
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

                                      if (event is FlTapUpEvent) {
                                        final categoryName = categoryCounts.keys
                                            .toList()[touchedIndex];
                                        if (Responsive.isMobile(context) ==
                                            true) {
                                          showCupertinoModalBottomSheet(
                                            context: context,
                                            builder: (context) =>
                                                CategoryDetailsScreen(
                                              categoryName: categoryName,
                                              sheetData: sheetData,
                                            ),
                                          );
                                        } else {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) =>
                                                CategoryDetailsScreen(
                                              categoryName: categoryName,
                                              sheetData: sheetData,
                                            ),
                                          );
                                        }
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) =>
                                        //         CategoryDetailsScreen(
                                        //       categoryName: categoryName,
                                        //       sheetData: sheetData,
                                        //     ),
                                        //   ),
                                        // );
                                      }
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
                                    color: Colors.accents[categoryCounts.keys
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
                          // const SizedBox(height: 20),
                          // touchedIndex != -1
                          //     ? Text(
                          //         '${categoryCounts.keys.toList()[touchedIndex]} - ${categoryCounts.values.toList()[touchedIndex]} items',
                          //         style: const TextStyle(fontSize: 16),
                          //       )
                          //     : const Text('Skrrt skrrt'),
                        ],
                      ),
                    ),
        ],
      ),
    );
  }
}

class CategoryDetailsScreen extends StatelessWidget {
  final String categoryName;
  final List<Map<String, dynamic>> sheetData;

  const CategoryDetailsScreen({
    super.key,
    required this.categoryName,
    required this.sheetData,
  });

  @override
  Widget build(BuildContext context) {
    final performerTasks = sheetData
        .where((row) => row['Category'].toString() == categoryName)
        .toList();

    // // Define the headers we want to show
    // const desiredHeaders = ['Job Order #', 'Category', 'Status', 'Performer'];

    // Assuming titleStyle is defined elsewhere; replace with your style if needed
    const titleStyle = TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('$categoryName Job Orders 💖', style: titleStyle),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: performerTasks.isNotEmpty
            ? ListView.builder(
                itemCount: performerTasks.length,
                itemBuilder: (context, index) {
                  final job = performerTasks[index];
                  // Use 'Job ID' if available, otherwise use index + 1
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
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      subtitle: Text(
                        'Category : ${job['Category']}',
                        style:
                            const TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: job.entries.map((entry) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
            : const Center(
                child: Text('No job orders found for this category')),
      ),
    );
  }
}

// // Task Details Screen
// class CategoryJODetailsSCreen extends StatelessWidget {
//   final Map<String, dynamic> task;

//   const CategoryJODetailsSCreen({
//     super.key,
//     required this.task,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 80,
//         title: Text(
//             '${task['Category']} JO ${task['Job Order #'] + " 💖" ?? 'Unknown'}',
//             style: titleStyle),
//         backgroundColor: Colors.black,
//         leading: IconButton(
//           color: Colors.white,
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const FaIcon(Icons.arrow_back_ios_new),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: task.entries.map((entry) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '${entry.key}: ',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         color: Colors.black,
//                       ),
//                     ),
//                     Expanded(
//                       child: Text(
//                         entry.value?.toString() ?? 'N/A',
//                         style: const TextStyle(
//                           fontSize: 16,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }
