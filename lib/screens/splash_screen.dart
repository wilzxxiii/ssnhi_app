// import 'package:flame_splash_screen/flame_splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:ssnhi_app/screens/authentication/sign_in.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   late FlameSplashController controller;
//   @override
//   void initState() {
//     super.initState();
//     controller = FlameSplashController(
//       fadeInDuration: const Duration(seconds: 1),
//       fadeOutDuration: const Duration(milliseconds: 250),
//       waitDuration: const Duration(seconds: 2),
//       autoStart: true,
//     );
//   }

//   @override
//   void dispose() {
//     controller.dispose(); // dispose it when necessary
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FlameSplashScreen(
//         showBefore: (BuildContext context) {
//           return Center(
//             child: Image.asset('assets/ssnhinc.png'),
//           );
//         },
//         showAfter: (BuildContext context) {
//           return Center(
//             child: Image.asset('assets/ssnhinc.png'),
//           );
//         },
//         theme: FlameSplashTheme.dark,
//         onFinish: (context) {
//           Navigator.pushReplacement(context,
//               MaterialPageRoute(builder: (context) => const SigninPage()));
//         },
//         controller: controller,
//       ),
//     );
//   }
// }
