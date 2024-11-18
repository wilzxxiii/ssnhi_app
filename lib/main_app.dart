import 'package:flutter/material.dart';
// import 'package:ssnhi_app/app_view.dart';
import 'package:ssnhi_app/screens/authentication/sign_in.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SSNHI App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SigninPage(),
    );
  }
}
