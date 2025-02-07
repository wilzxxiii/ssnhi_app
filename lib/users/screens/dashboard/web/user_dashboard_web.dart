// import 'package:flutter/material.dart';
// // import 'package:ssnhi_app/screens/barcode/barcode_screen.dart';
// import 'package:ssnhi_app/screens/chat/chat_agent.dart';
// import 'package:ssnhi_app/screens/dashboard/mobile/user_dashboard_mobile_drawer.dart';
// // import 'package:ssnhi_app/screens/dashboard/user_dashboard_appbar.dart';
// // import 'package:ssnhi_app/screens/dashboard/web/user_dashboard_web_body.dart';
// import 'package:ssnhi_app/shared/constants/constants.dart';

// class UserDashboardWebView extends StatelessWidget {
//   const UserDashboardWebView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // final authState = June.getState(() => AuthState());
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.only(left: 150, right: 150),
//         child: Scaffold(
//           floatingActionButton: FloatingActionButton(
//             onPressed: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const ChatAgentSreen()));
//             },
//             backgroundColor: mainColor,
//             tooltip: 'Chat with AI',
//             child: const Icon(
//               Icons.chat,
//               color: Colors.white,
//             ),
//           ),
//           drawer: const UserDashboardMobileDrawer(),
//           appBar: AppBar(
//             iconTheme: const IconThemeData(color: iconColor),
//             centerTitle: true,
//             title: SizedBox(
//               height: 95,
//               child: Image.asset(
//                 'brando_white.png',
//                 height: 93,
//               ),
//             ),
//             toolbarHeight: 100,
//             elevation: 10,
//             backgroundColor: mainColor,
//           ),
//         ),
//       ),
//     );
//     // Scaffold(
//     //   backgroundColor: Colors.white60,
//     //   floatingActionButton: FloatingActionButton(
//     //     onPressed: () {
//     //       Navigator.push(context,
//     //           MaterialPageRoute(builder: (context) => const BarcodeScreen()));
//     //     },
//     //     backgroundColor: mainColor,
//     //     tooltip: 'Chat with AI',
//     //     child: const Icon(
//     //       Icons.chat,
//     //       color: Colors.white,
//     //     ),
//     //   ),
//     //   body: const SafeArea(
//     //     child: Column(
//     //       children: [
//     //         UserDashboardAppbar(),
//     //         UserDashboardWebBody(),
//     //       ],
//     //     ),
//     //   ),
//     // );
//   }
// }
