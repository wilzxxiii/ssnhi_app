import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

class MonthlyCategoryDetailsScreen extends StatelessWidget {
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
    final monthNum = monthMap[selectedMonth];

    // Filter job orders by category, month, and year
    final filteredJobOrders = sheetData.where((row) {
      var dateStr = row['Date Finished']?.toString() ?? '';
      if (dateStr.isEmpty) return false;

      try {
        var date = DateFormat('MM/dd/yyyy').parse(dateStr, true);
        return row['Category'] == categoryName &&
            date.month == monthNum &&
            date.year == selectedYear;
      } catch (e) {
        debugPrint('Error parsing date "$dateStr": $e');
        return false;
      }
    }).toList();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: IconButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const FaIcon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          'Job Orders for $categoryName - $selectedMonth $selectedYear 💖',
          style: titleStyle,
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: filteredJobOrders.isNotEmpty
            ? ListView.builder(
                itemCount: filteredJobOrders.length,
                itemBuilder: (context, index) {
                  final job = filteredJobOrders[index];
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
