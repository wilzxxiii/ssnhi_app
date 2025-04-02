// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:june/june.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// import 'package:ssnhi_app/shared/constants/constants.dart';
// import 'package:ssnhi_app/shared/utils/responsive.dart';
// import 'package:ssnhi_app/users/shared_screen/charts/state/material_used_state.dart';

// class MaterialUsedScreen extends StatelessWidget {
//   const MaterialUsedScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return JuneBuilder(() => MaterialUsedState(), builder: (materialUsedState) {
//       return Scaffold(
//         appBar: AppBar(
//           toolbarHeight: appBarHeight,
//           backgroundColor: lightBackground,
//           leading: IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: const FaIcon(
//                 Icons.close,
//                 color: Colors.black,
//               )),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(5),
//           child: materialUsedState.isLoading
//               ? const Center(child: CircularProgressIndicator())
//               : materialUsedState.sheetData.isEmpty
//                   ? const Center(child: Text('No data found'))
//                   : Container(
//                       width: MediaQuery.of(context).size.width,
//                       padding: const EdgeInsets.all(10),
//                       decoration: const BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(20),
//                         ),
//                       ),
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.vertical,
//                         child: Column(
//                           children: [
//                             const Center(
//                               child: Text(
//                                 'Materials Used 💫',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             // const Center(
//                             //   child: Text(
//                             //     'P.S. You can click their names 🤭',
//                             //     style: TextStyle(
//                             //       color: Colors.white,
//                             //       fontSize: 12,
//                             //     ),
//                             //   ),
//                             // ),
//                             const SizedBox(height: 10),
//                             DataTable(
//                               columns: const [
//                                 DataColumn(
//                                   label: Text(
//                                     'Materials Used for concerns',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                               rows: () {
//                                 final sortedEntries = materialUsedState
//                                     .materialsUsed.entries
//                                     .toList();
//                                 sortedEntries
//                                     .sort((a, b) => b.value.compareTo(a.value));
//                                 return sortedEntries.map((entry) {
//                                   return DataRow(
//                                     cells: [
//                                       DataCell(
//                                         MouseRegion(
//                                           cursor: SystemMouseCursors.click,
//                                           child: GestureDetector(
//                                             onTap: () {
//                                               // if (Responsive.isMobile(
//                                               //     context)) {
//                                               //   showCupertinoModalBottomSheet(
//                                               //     context: context,
//                                               //     builder: (context) =>
//                                               //         MaterialUsedScreenDetails(
//                                               //       materialName: entry.key,
//                                               //       sheetData: materialUsedState
//                                               //           .sheetData,
//                                               //     ),
//                                               //   );
//                                               // } else {
//                                               //   showModalBottomSheet(
//                                               //     context: context,
//                                               //     builder: (context) =>
//                                               //         MaterialUsedScreenDetails(
//                                               //       materialName: entry.key,
//                                               //       sheetData: materialUsedState
//                                               //           .sheetData,
//                                               //     ),
//                                               //   );
//                                               // }
//                                             },
//                                             child: Text(
//                                               "${entry.key} was used ${entry.value} for${entry.value == 1 ? '' : 's'}",
//                                               style: const TextStyle(
//                                                 color: Colors.white,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 }).toList();
//                               }(),
//                               columnSpacing: 20,
//                               horizontalMargin: 10,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//         ),
//       );
//     });
//   }
// }

// // Updated Performer Details Screen with Clickable Rows
// class MaterialUsedScreenDetails extends StatefulWidget {
//   final String materialName;
//   final List<Map<String, dynamic>> sheetData;

//   const MaterialUsedScreenDetails({
//     super.key,
//     required this.materialName,
//     required this.sheetData,
//   });

//   @override
//   State<MaterialUsedScreenDetails> createState() =>
//       _MaterialUsedScreenDetailsState();
// }

// class _MaterialUsedScreenDetailsState extends State<MaterialUsedScreenDetails> {
//   String searchQuery = ''; // To store the search input

//   @override
//   Widget build(BuildContext context) {
//     // Filter sheetData for the selected department and search query
//     final materialUsed = widget.sheetData
//         .where((row) => row['MaterialUsed'].toString() == widget.materialName)
//         .where((row) =>
//             searchQuery.isEmpty ||
//             row['Job Order #']
//                     ?.toString()
//                     .toLowerCase()
//                     .contains(searchQuery.toLowerCase()) ==
//                 true)
//         .toList();

//     // Assuming titleStyle and darkBackground are defined elsewhere
//     const titleStyle = TextStyle(
//       color: Colors.white,
//       fontSize: 20,
//       fontWeight: FontWeight.bold,
//     );

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('${widget.materialName} Job Orders 💖', style: titleStyle),
//         backgroundColor: darkBackground,
//         toolbarHeight: appBarHeight,
//         leading: IconButton(
//           color: Colors.white,
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const FaIcon(Icons.close_rounded),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Search Box
//             Padding(
//               padding: const EdgeInsets.only(bottom: 16.0),
//               child: TextField(
//                 textInputAction: TextInputAction.search,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   hintText: 'Search Job Order #',
//                   prefixIcon: const Icon(Icons.search),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//                 onChanged: (value) {
//                   setState(() {
//                     searchQuery = value;
//                   });
//                 },
//               ),
//             ),
//             Expanded(
//               child: materialUsed.isNotEmpty
//                   ? ListView.builder(
//                       itemCount: materialUsed.length,
//                       itemBuilder: (context, index) {
//                         final job = materialUsed[index];
//                         return Card(
//                           color: Colors.black,
//                           elevation: 2,
//                           margin: const EdgeInsets.symmetric(vertical: 8),
//                           child: ExpansionTile(
//                             iconColor: Colors.white,
//                             collapsedIconColor: Colors.blue[300],
//                             title: Text(
//                               'Job Order ${job['Job Order #']} ✨',
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white),
//                             ),
//                             subtitle: Text(
//                               'Category: ${job['Category'] ?? 'N/A'}',
//                               style: const TextStyle(
//                                   fontSize: 12, color: Colors.white),
//                             ),
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(16.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: job.entries.map((entry) {
//                                     return Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: 4.0),
//                                       child: Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             '${entry.key}:  ',
//                                             style: const TextStyle(
//                                                 color: Colors.white,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                           Expanded(
//                                             child: Text(
//                                               entry.value?.toString() ?? 'N/A',
//                                               softWrap: true,
//                                               style: const TextStyle(
//                                                   color: Colors.white),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   }).toList(),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     )
//                   : const Center(child: Text('No matching job orders found')),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
