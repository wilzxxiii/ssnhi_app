import 'package:flutter/material.dart';

class SignUpSidePanel extends StatelessWidget {
  const SignUpSidePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: Colors.blueAccent),
    );
  }
}
