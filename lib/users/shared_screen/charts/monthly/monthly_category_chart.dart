import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

class MonthlyCategoryDetailsScreen extends StatefulWidget {
  final String categoryName;
  final List<Map<String, dynamic>> sheetData;
  final String? selectedMonth;
  final int? selectedYear;

  const MonthlyCategoryDetailsScreen({
    super.key,
    required this.categoryName,
    required this.sheetData,
    required this.selectedMonth,
    required this.selectedYear,
  });

  @override
  State<MonthlyCategoryDetailsScreen> createState() =>
      _MonthlyCategoryDetailsScreenState();
}

class _MonthlyCategoryDetailsScreenState
    extends State<MonthlyCategoryDetailsScreen> {
  String searchQuery = ''; // To store the search input

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

    // Filter sheetData for the selected category, month, year, and search query
    final categoryTasks = widget.sheetData.where((row) {
      var category = row['Category']?.toString() ?? 'Uncategorized';
      var dateStr = row['Date Finished']?.toString() ?? '';
      if (dateStr.isEmpty) return false;

      try {
        var date = DateFormat('M/d/yyyy').parse(dateStr, true);
        return category == widget.categoryName &&
            date.month == monthNum &&
            date.year == widget.selectedYear! &&
            (searchQuery.isEmpty ||
                row['Job Order #']
                        ?.toString()
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()) ==
                    true);
      } catch (e) {
        return false;
      }
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.categoryName} - Details 💖', style: titleStyle),
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
              child: categoryTasks.isNotEmpty
                  ? ListView.builder(
                      itemCount: categoryTasks.length,
                      itemBuilder: (context, index) {
                        final job = categoryTasks[index];
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
                              'Work Requested: ${job['Work Requested'] ?? 'N/A'}',
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
