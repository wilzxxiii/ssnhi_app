import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:ssnhi_app/shared/utils/responsive.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({super.key});

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  String? scanResult;
  String? barcodeResult;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Responsive.isDesktop(context)
          ? const EdgeInsets.all(100)
          : const EdgeInsets.all(20),
      child: SafeArea(
        child: Column(
          children: [
            Text(scanResult == null ? 'Scan Barcode' : scanResult!),
            const SizedBox(
              height: 20,
            ),
            BarcodeWidget(
              barcode: Barcode.code128(), // Barcode type and settings
              data: barcodeResult.toString(), // Content
              width: 200,
              height: 200,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  barcodeResult = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // String? res = await SimpleBarcodeScanner.scanBarcode(context,
  //     barcodeAppBar: const BarcodeAppBar(
  //       appBarTitle: 'Test',
  //       centerTitle: false,
  //       enableBackButton: true,
  //       backButtonIcon: Icon(Icons.arrow_back_ios),
  //     ),
  //     scanType: ScanType.barcode,
  //     isShowFlashIcon: true,
  //     delayMillis: 2000,
  //     cameraFace: CameraFace.front,
  //     cancelButtonText: 'Cancel');
  // setState(() {
  //   scanResult = res as String;
  // });
  // Future scanBarcode() async {
  //   String scanResult;

  //   try {
  //     scanResult = await FlutterBarcodeScanner.scanBarcode(
  //         "#ff6666", "Cancel", true, ScanMode.BARCODE);
  //   } on PlatformException {
  //     scanResult = 'Failed to get barcode';
  //   }
  //   if (!mounted) {
  //     return;
  //   }

  //   setState(() {
  //     this.scanResult = scanResult;
  //   });
  // }
}
