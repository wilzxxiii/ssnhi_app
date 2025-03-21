import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:june/june.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ssnhi_app/shared/utils/responsive.dart';
import 'package:ssnhi_app/users/screens/dashboard/charts/state/request_per_dept_state.dart';

class RequestPerDepartments extends StatelessWidget {
  const RequestPerDepartments({super.key});

  @override
  Widget build(BuildContext context) {
    return JuneBuilder(() => RequestPerDeptState(), builder: (reqDeptState) {
      return Padding(
        padding: const EdgeInsets.all(5),
        child: reqDeptState.isLoading
            ? const Center(child: CircularProgressIndicator())
            : reqDeptState.sheetData.isEmpty
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'Job Orders by Department 💫',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Center(
                            child: Text(
                              'P.S. You can click department names 🤭',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          DataTable(
                            columns: const [
                              DataColumn(
                                label: Text(
                                  'Department',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  '# of requests',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                            rows: () {
                              final sortedEntries =
                                  reqDeptState.categoryCounts.entries.toList();
                              sortedEntries
                                  .sort((a, b) => b.value.compareTo(a.value));
                              return sortedEntries.map((entry) {
                                return DataRow(
                                  cells: [
                                    DataCell(MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (Responsive.isMobile(context) ==
                                              true) {
                                            showCupertinoModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  DepartmentDetailsScreen(
                                                deptName: entry.key,
                                                sheetData:
                                                    reqDeptState.sheetData,
                                              ),
                                            );
                                          } else {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  DepartmentDetailsScreen(
                                                deptName: entry.key,
                                                sheetData:
                                                    reqDeptState.sheetData,
                                              ),
                                            );
                                          }
                                        },
                                        child: Text(
                                          entry.key,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )),
                                    DataCell(Text(
                                      entry.value.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    )),
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
    });
  }
}

// Updated Performer Details Screen with Clickable Rows
class DepartmentDetailsScreen extends StatelessWidget {
  final String deptName;
  final List<Map<String, dynamic>> sheetData;

  const DepartmentDetailsScreen({
    super.key,
    required this.deptName,
    required this.sheetData,
  });

  @override
  Widget build(BuildContext context) {
    // Filter sheetData for the selected performer
    final deptRequests = sheetData
        .where((row) => row['Requestor Department'].toString() == deptName)
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
        title: Text('$deptName Job Orders 💖', style: titleStyle),
        backgroundColor: Colors.black,
        toolbarHeight: 70,
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
        child: deptRequests.isNotEmpty
            ? ListView.builder(
                itemCount: deptRequests.length,
                itemBuilder: (context, index) {
                  final job = deptRequests[index];
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

// Task Details Screen
// class DepartmentJODetailsScreen extends StatelessWidget {
//   final Map<String, dynamic> task;

//   const DepartmentJODetailsScreen({
//     super.key,
//     required this.task,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 80,
//         title: Text('${task['Requestor Department'] + " JO 💖" ?? 'Unknown'}',
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
