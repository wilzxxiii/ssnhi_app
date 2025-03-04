import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen {
  Future<void> showLoading(BuildContext context) {
    return showDialog(
        // barrierDismissible: false,
        context: context,
        builder: (_) {
          return const Center(
            child: SpinKitFoldingCube(
              color: Colors.black,
            ),
          );
        });
  }
}
