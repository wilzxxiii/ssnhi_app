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
              ),
            ],
          );
        });
  }
}

class MyDialog {
  Future<void> logOutDialog(BuildContext context, Function function) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to log out cutie? 🌙'),
          content: const SingleChildScrollView(),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                function;
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
