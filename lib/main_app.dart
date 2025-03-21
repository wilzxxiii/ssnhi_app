import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:ssnhi_app/user_check.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
        textTheme: GoogleFonts.forumTextTheme(),
      ),
      home: const UserChecker(),
    );
  }
}
