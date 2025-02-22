import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:ssnhi_app/main_app.dart';

// import 'package:ssnhi_bcscan/main_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Firebase initialization
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDGsSqyeWAg5chK4CLiSxoEktJmURHMn-s",
      appId: "1:763661840962:web:1d0629cafa8e52414bf3db",
      messagingSenderId: "763661840962",
      projectId: "ssnhi-app",
    ),
  );

//Google Gemini AI

  runApp(const MainApp());
}

// void main() {
//   runApp(const MainApp());
// }


//
//MaterialApp(
 //       debugShowCheckedModeBanner: false,
   //     title: 'Barcode Scanner',
     //   theme: ThemeData(
       //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
         // useMaterial3: true,
       // ),
        //home: const SplashScreen(),
      //),