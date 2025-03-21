import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:june/state_manager/src/simple/controllers.dart';
import 'package:ssnhi_app/data/google_sheet.dart';

class MonthlySummaryChartState extends JuneState {
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

  MonthlySummaryChartState() {
    _fetchData();
  }

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

  Future<void> _fetchData() async {
    try {
      final response = await http.get(Uri.parse(sheetUrl));
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var values = json['values'] as List;
        if (values.isEmpty) {
          isLoading = false;
          setState();
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

        isLoading = false;
        setState();
      } else {
        isLoading = false;
        setState();
      }
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Error: $e')),
      // );
      isLoading = false;
      setState();
    }
  }

  void filterData() {
    if (selectedMonth == null || selectedYear == null) {
      log('Error');

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
        continue;
      }
    }

    setState();
  }
}
