import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

class LoadingScreen {
  Future<void> showLoading(BuildContext context) {
    return showDialog(
        // barrierDismissible: false,
        context: context,
        builder: (_) {
          return Column(
            // crossAxisAlignment: CrossA
            children: [
              SizedBox(
                height: 240,
                width: 240,
                child: Image.asset(
                  'assets/logo.png',
                  colorBlendMode: BlendMode.clear,
                ),
              ),
              const Text(
                '"Believe in something 🌙"',
                style: titleStyleDark,
              ),
              const SizedBox(
                height: 30,
              ),
              const SpinKitFoldingCube(
                color: Colors.black,
              )
            ],
          );
        });
  }
}
