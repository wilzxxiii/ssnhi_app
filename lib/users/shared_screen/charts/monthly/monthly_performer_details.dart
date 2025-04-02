import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:ssnhi_app/shared/utils/google_sheet.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'dart:convert';

class MonthlyPerformerDetailsScreen extends StatefulWidget {
  final String performerName;
  final List<Map<String, dynamic>> sheetData; // Entities sheet data
  final String? selectedMonth;
  final int? selectedYear;

  const MonthlyPerformerDetailsScreen({
    super.key,
    required this.performerName,
    required this.sheetData,
    required this.selectedMonth,
    required this.selectedYear,
  });

  @override
  State<MonthlyPerformerDetailsScreen> createState() =>
      _MonthlyPerformerDetailsScreenState();
}

class _MonthlyPerformerDetailsScreenState
    extends State<MonthlyPerformerDetailsScreen> {
  String searchQuery = '';
  late Future<List<Map<String, dynamic>>> _joDataFuture;

  @override
  void initState() {
    super.initState();
    // Get the performer's Job Order #s from the Entities sheet
    var staffData = widget.sheetData.firstWhere(
      (row) => row['Staff Name'] == widget.performerName,
      orElse: () => {'Job Orders': ''},
    );
    var jobOrders = staffData['Job Orders']
            ?.toString()
            .split(", ")
            .where((jo) => jo.isNotEmpty)
            .toList() ??
        [];
    _joDataFuture = _fetchJOData(jobOrders);
  }

  Future<List<Map<String, dynamic>>> _fetchJOData(
      List<String> jobOrders) async {
    const url =
        sheetsUrl; // Adjust this to the "JO Data Draft" sheet URL if different
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

        // Filter by Job Order #s associated with the performer
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
    final monthNum = monthMap[widget.selectedMonth] ?? 0;

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
                future: _joDataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child:
                            Text('No job orders found for this staff member'));
                  }

                  // Filter tasks by month, year, and search query
                  final performerTasks = snapshot.data!.where((job) {
                    var dateStr = job['Date Finished']?.toString() ?? '';
                    if (dateStr.isEmpty) return false;

                    try {
                      var date = DateFormat('M/d/yyyy').parse(dateStr, true);
                      return date.month == monthNum &&
                          date.year == widget.selectedYear! &&
                          (searchQuery.isEmpty ||
                              job['Job Order #']
                                      ?.toString()
                                      .toLowerCase()
                                      .contains(searchQuery.toLowerCase()) ==
                                  true);
                    } catch (e) {
                      return false;
                    }
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
