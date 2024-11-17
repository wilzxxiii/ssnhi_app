import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ssnhi_bcscan/main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}




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