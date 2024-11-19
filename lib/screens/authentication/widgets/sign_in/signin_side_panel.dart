import 'package:flutter/material.dart';

class SignInSidePanel extends StatelessWidget {
  const SignInSidePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: Colors.lightBlueAccent),
      child: Center(
        child: Image.asset(
          'assets/ssnhinc.png',
          colorBlendMode: BlendMode.clear,
        ),
      ),
    );
  }
}
