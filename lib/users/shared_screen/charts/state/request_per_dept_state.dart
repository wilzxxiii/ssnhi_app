import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:june/state_manager/src/simple/controllers.dart';
import 'package:ssnhi_app/shared/utils/google_sheet.dart';

class RequestPerDeptState extends JuneState {
  List<Map<String, dynamic>> sheetData = [];
  Map<String, int> categoryCounts = {};
  bool isLoading = true;

  RequestPerDeptState() {
    // Initialize the Firestore stream listener
    _fetchData();
  }

  Future<void> _fetchData() async {
    const url = sheetsUrl;

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var values = json['values'] as List;
        if (values.isEmpty) {
          isLoading = false;
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
          String category = row['Requestor Department'].toString();
          categoryCounts[category] = (categoryCounts[category] ?? 0) + 1;
        }

        isLoading = false;
        setState();
      } else {
        isLoading = false;
        setState();
      }
    } catch (e) {
      isLoading = false;
      setState();
    }
  }
}
