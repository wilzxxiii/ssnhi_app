import 'package:flutter/material.dart';
import 'package:ssnhi_app/screens/barcode/mobile/barcode_screen_mobile.dart';
import 'package:ssnhi_app/screens/barcode/web/barcode_screen_web.dart';
import 'package:ssnhi_app/shared/utils/responsive.dart';

class BarcodeScreen extends StatelessWidget {
  const BarcodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context) == true) {
      return const BarcodeScreenMobile();
    } else {
      return const BarcodeScreenWeb();
    }
  }
}
