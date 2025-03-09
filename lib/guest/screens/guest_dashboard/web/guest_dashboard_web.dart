import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ssnhi_app/data/google_sheet.dart';

import 'package:ssnhi_app/users/screens/authentication/sign%20in/sign_in.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;

class GuestDashboardWeb extends StatefulWidget {
  const GuestDashboardWeb({super.key});

  @override
  State<GuestDashboardWeb> createState() => _GuestDashboardWebState();
}

class _GuestDashboardWebState extends State<GuestDashboardWeb> {
  void _openInNewTab(String url) {
    html.window.open(url,
        'https://echow.xyz/user/0xa5e2460c562438a47f385322b8e1108A4DC788a9');
  }

  List<Map<String, dynamic>> sheetData = [];
  Map<String, int> categoryCounts = {};
  bool isLoading = true;

  Future<void> fetchData() async {
    // const sheetId = "1v95m_vU2W8ZyxTg_NCYQcxMQniBqaBtxxbUTLOByS0I";
    // const apiKey = googleCloudApiKey; // Replace with your API key
    // const range =
    //     'JO Data!A3:N'; // Fetch A3:N (adjust last row dynamically if needed)
    const url = sheetsUrl;

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var values = json['values'] as List;
        if (values.isEmpty) {
          print('No values returned');
          setState(() => isLoading = false);
          return;
        }

        // Extract headers from A3:N3
        var headers = values[0];
        // Extract data rows from A4 onward
        var dataRows = values.length > 1 ? values.sublist(1) : [];

        // Map data rows to sheetData
        sheetData = dataRows.map((row) {
          var rowMap = <String, dynamic>{};
          for (int i = 0; i < headers.length && i < row.length; i++) {
            rowMap[headers[i]] = row[i];
          }
          return rowMap;
        }).toList();

        // Aggregate counts by CategoryJO
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: lightBackground,
        leading: Image.asset('assets/logo.png'),
        title: const Text(
          'Believe in something 🌙',
          style: titleStyleDark,
        ),
        elevation: 5,
        shadowColor: Colors.blue,
        actions: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.black, //<-- SEE HERE
              elevation: 10,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SigninPage()));
            },
            child: const Text(
              'Sign in',
              style: titleStyle,
            ),
          ),
          const SizedBox(
            width: 50,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.orange,
                // image: DecorationImage(
                //     image: AssetImage('assets/brando_black.png'),
                //     fit: BoxFit.contain),
              ),
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Container(
                  padding: const EdgeInsets.all(40),
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : sheetData.isEmpty
                          ? const Center(child: Text('No data found'))
                          : Center(
                              child: SizedBox(
                                width: 300,
                                height: 300,
                                child: PieChart(
                                  PieChartData(
                                    sections:
                                        categoryCounts.entries.map((entry) {
                                      return PieChartSectionData(
                                        value: entry.value.toDouble(),
                                        title: entry.key,
                                        color: Colors.primaries[categoryCounts
                                                .keys
                                                .toList()
                                                .indexOf(entry.key) %
                                            Colors.primaries.length],
                                        radius: 100,
                                        titleStyle: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      );
                                    }).toList(),
                                    sectionsSpace: 2,
                                    centerSpaceRadius: 40,
                                  ),
                                ),
                              ),
                            ),

                  // child: GridView(
                  //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 2, // 2 columns
                  //     mainAxisExtent: MediaQuery.of(context).size.height * 0.5,
                  //     crossAxisSpacing: 16, // Horizontal spacing between cards
                  //     mainAxisSpacing: 16, // Vertical spacing between cards
                  //     childAspectRatio: 0.75, // Adjust card height/width ratio
                  //   ),
                  //   children: [
                  //     //Report
                  //     Container(
                  //       decoration: const BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.all(
                  //           Radius.circular(20),
                  //         ),
                  //       ),
                  //     ),
                  //     //For ID
                  //     Container(
                  //         padding: const EdgeInsets.all(20),
                  //         decoration: const BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.all(
                  //             Radius.circular(20),
                  //           ),
                  //         ),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             const Text(
                  //               'For ID\'s 💫',
                  //               style: titleStyleDark,
                  //             ),
                  //             SizedBox(
                  //               height:
                  //                   MediaQuery.of(context).size.height * 0.35,
                  //               width: MediaQuery.of(context).size.width,
                  //               child: JuneBuilder(() => ForIdState(),
                  //                   builder: (forIdState) {
                  //                 return forIdState.isLoading
                  //                     ? const Center(
                  //                         child: SpinKitFoldingCube(
                  //                           color: Colors.black,
                  //                         ),
                  //                       )
                  //                     : forIdState.errorMessage != null
                  //                         ? Center(
                  //                             child: Text(
                  //                                 'Error: ${forIdState.errorMessage}'))
                  //                         : forIdState.forIdList.isEmpty
                  //                             ? const Center(
                  //                                 child:
                  //                                     Text('No records found'))
                  //                             : ListView.builder(
                  //                                 itemCount: forIdState
                  //                                     .forIdList.length,
                  //                                 itemBuilder:
                  //                                     (context, index) {
                  //                                   final forId = forIdState
                  //                                       .forIdList[index];
                  //                                   return ForIdCard(
                  //                                     forId: forId,
                  //                                     vm: forIdState,
                  //                                   );
                  //                                 },
                  //                               );
                  //               }),
                  //             ),
                  //             Center(
                  //               child: TextButton(
                  //                   onPressed: () {
                  //                     Navigator.push(
                  //                         context,
                  //                         MaterialPageRoute(
                  //                             builder: (context) =>
                  //                                 const ForID()));
                  //                   },
                  //                   child: const Text(
                  //                     'View all 👀',
                  //                     style: titleStyleDark,
                  //                   )),
                  //             )
                  //           ],
                  //         )),
                  //     //IT Report
                  //     Container(
                  //       decoration: const BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.all(
                  //           Radius.circular(20),
                  //         ),
                  //       ),
                  //     ),
                  //     //To be decided
                  //     Container(
                  //       decoration: const BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.all(
                  //           Radius.circular(20),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Center(
                child: Row(
                  children: [
                    const Text(
                      'Copyright © 2025. Brando, All Rights Reserved. Support the dev by buying his art here: ',
                      style: titleStyle,
                    ),
                    TextButton(
                      onPressed: () {
                        _openInNewTab(
                            'https://echow.xyz/user/0xa5e2460c562438a47f385322b8e1108A4DC788a9');
                      },
                      child: const Text(
                        'Echow.xyz',
                        style: titleStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
