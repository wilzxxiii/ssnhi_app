import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:june/state_manager/src/simple/controllers.dart';
import 'package:ssnhi_app/shared/utils/google_sheet.dart';

class PerformerChartState extends JuneState {
  List<Map<String, dynamic>> sheetData = [];
  Map<String, int> staffTotals = {};
  bool isLoading = true;

  PerformerChartState() {
    _fetchData();
  }

  Future<void> _fetchData() async {
    const url = entitiesSheetUrl;

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var values = json['values'] as List;
        if (values.isEmpty) {
          isLoading = false;
          setState();
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

        staffTotals.clear();
        for (var row in sheetData) {
          String staffName = row['Staff Name']?.toString() ?? 'Unknown';
          // Parse Total JO as an integer, default to 0 if empty or invalid
          int totalJo = int.tryParse(row['Total JO']?.toString() ?? '0') ?? 0;
          staffTotals[staffName] = totalJo;
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
