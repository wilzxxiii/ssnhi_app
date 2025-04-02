import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:june/state_manager/src/simple/controllers.dart';
import 'package:ssnhi_app/shared/utils/google_sheet.dart';

class MonthlySummaryChartState extends JuneState {
  List<Map<String, dynamic>> joData = []; // From "JO Data Draft"
  List<Map<String, dynamic>> entitiesData = []; // From "Entities"
  bool isLoading = true;
  String? selectedMonth;
  int? selectedYear;
  int touchedIndex = -1;

  Map<String, int> categoryCount = {};
  Map<String, int> performerCount = {};
  Map<String, int> materialUsedCount = {};
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

  Future<void> _fetchData() async {
    const joDataSheetUrl = sheetsUrl;

    try {
      // Fetch JO Data Draft
      final joResponse = await http.get(Uri.parse(joDataSheetUrl));
      if (joResponse.statusCode == 200) {
        var json = jsonDecode(joResponse.body);
        var values = json['values'] as List;
        if (values.isNotEmpty) {
          var headers = values[0];
          var dataRows = values.sublist(1);

          joData = dataRows.map((row) {
            var rowMap = <String, dynamic>{};
            for (int i = 0; i < headers.length && i < row.length; i++) {
              rowMap[headers[i]] = row[i];
            }
            return rowMap;
          }).toList();
        } else {}
      } else {}

      // Fetch Entities
      final entitiesResponse = await http.get(Uri.parse(entitiesSheetUrl));
      if (entitiesResponse.statusCode == 200) {
        var json = jsonDecode(entitiesResponse.body);
        var values = json['values'] as List;
        if (values.isNotEmpty) {
          var headers = values[0];
          var dataRows = values.sublist(1);

          entitiesData = dataRows.map((row) {
            var rowMap = <String, dynamic>{};
            for (int i = 0; i < headers.length && i < row.length; i++) {
              rowMap[headers[i]] = row[i];
            }
            return rowMap;
          }).toList();
        } else {}
      } else {}

      isLoading = false;
      setState();
    } catch (e) {
      isLoading = false;
      setState();
    }
  }

  void filterData() {
    if (selectedMonth == null || selectedYear == null) {
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
    final monthNum = monthMap[selectedMonth!]!;

    categoryCount.clear();
    performerCount.clear();
    materialUsedCount.clear();
    workRequestedCount.clear();

    //  Process JO Data Draft for category and work requested counts

    for (var row in joData) {
      var dateStr = row['Date Finished']?.toString() ?? '';
      if (dateStr.isEmpty) {
        continue;
      }

      try {
        var date = DateFormat('M/d/yyyy').parse(dateStr, true);
        if (date.month == monthNum && date.year == selectedYear!) {
          // Category Count
          var category = row['Category']?.toString() ?? 'Uncategorized';
          categoryCount[category] = (categoryCount[category] ?? 0) + 1;

          // Materials Used Count - Skip if null or empty
          var materials = row['Material Used']?.toString();
          if (materials != null && materials.isNotEmpty) {
            if (materials.contains(',')) {
              var materialList =
                  materials.split(',').map((m) => m.trim()).toList();
              for (var material in materialList) {
                if (material.isNotEmpty) {
                  // Skip empty items in comma-separated list
                  materialUsedCount[material] =
                      (materialUsedCount[material] ?? 0) + 1;
                }
              }
            } else {
              materialUsedCount[materials] =
                  (materialUsedCount[materials] ?? 0) + 1;
            }
          }

          // // Materials Used
          // if (categories.contains(category)) {
          //   var materialsUsed =
          //       row['Materials Used']?.toString() ?? 'Unspecified';
          //   materialsUsed[mat] ??= {};
          //   materialsUsed[category]![materialsUsed] =
          //       (workRequestedCount[category]![materialsUsed] ?? 0) + 1;
          // }

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

    // Process Entities for performer counts
    // Create a map of JobOrderNumber to DateCompletedJO
    Map<String, DateTime> jobOrderDates = {};

    for (var row in joData) {
      var jobOrderNumber = row['Job Order #']?.toString() ?? '';
      var dateStr = row['Date Finished']?.toString() ?? '';
      if (jobOrderNumber.isEmpty || dateStr.isEmpty) {
        continue;
      }

      try {
        var date = DateFormat('M/d/yyyy')
            .parse(dateStr, true); // Fixed: Use M/d/yyyy format
        jobOrderDates[jobOrderNumber] = date;
      } catch (e) {
        continue;
      }
    }

    // Count performers using Entities

    for (var row in entitiesData) {
      var staffName = row['Staff Name']?.toString() ?? 'Unspecified';
      var jobOrders = row['Job Orders']
              ?.toString()
              .split(", ")
              .where((jo) => jo.isNotEmpty)
              .toList() ??
          [];
      var count = 0;

      for (var jobOrder in jobOrders) {
        var date = jobOrderDates[jobOrder];
        if (date != null &&
            date.month == monthNum &&
            date.year == selectedYear!) {
          count++;
        }
      }

      if (count > 0) {
        performerCount[staffName] = count;
      }
    }

    setState();
  }
}
