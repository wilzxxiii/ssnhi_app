import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:june/june.dart';
import 'package:signature/signature.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_db_service.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_model.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:ssnhi_app/users/screens/loading_screen.dart';
import 'package:universal_html/html.dart' as html;

class ForIdState extends JuneState {
  String empNo = '';
  String empName = '';
  String empDept = ''; // No default value since it's now a text field
  String ecName = '';
  String ecAdd = '';
  String ecPhone = '';
  String signature = '';
  String status = '';
  //My model
  ForIdModel? _forIdModel;

  ForIdModel? get forIdModel => _forIdModel;

  final dbForId = ForIdDbService();
  final loading = LoadingScreen();

//
  // Firestore list-related state (from ForIdState)
  List<ForIdModel> forIdList = [];
  bool isLoading = true;
  String? errorMessage;

  ForIdState() {
    // Initialize the Firestore stream listener
    _initFirestoreListener();
  }

  // Initialize Firestore stream listener (from ForIdState)
  void _initFirestoreListener() {
    dbForId.getAllForIDsStream().listen(
      (list) {
        forIdList = list;
        isLoading = false;
        errorMessage = null;
        setState();
      },
      onError: (error) {
        isLoading = false;
        errorMessage = error.toString();
        setState();
      },
      onDone: () {
        isLoading = false;
        setState();
      },
    );
  }

  //Signature controller
  final SignatureController sigController = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
    exportPenColor: Colors.black,
  );

  //TextEditing Controllers
  final GlobalKey<FormState> forIdformKey = GlobalKey<FormState>();

  // TextEditingController instances for each text field
  final TextEditingController empNoController = TextEditingController();
  // final TextEditingController empDepartmentController = TextEditingController();
  final TextEditingController empPositionController = TextEditingController();
  final TextEditingController empNameController = TextEditingController();
  final TextEditingController ecNameController = TextEditingController();
  final TextEditingController ecAddController = TextEditingController();
  final TextEditingController ecPhoneController = TextEditingController();

  // // Optional: Method to pre-fill form with existing data for editing
  void loadForIdModel(ForIdModel model) {
    empNoController.text = model.empNo;
    empNameController.text = model.empName;
    empDept = model.empDept;
    empPositionController.text = model.position;
    ecNameController.text = model.ecName;
    ecAddController.text = model.ecAdd;
    ecPhoneController.text = model.ecPhone;
    signature = model.signature;
    status = model.status;
    _forIdModel = model;
    setState();
  }

  //For dropdown
  List<String> idStatus = [
    'Gathering Info',
    'Working',
    'Done',
  ];

  List<String> department = [
    'Admin',
    'Ancilliary',
    'Nursing',
  ];
//
//
//
//
//
  ///
////
/////
////
  ///
//
//Convert Signature to string method
  Future<void> convertSignatureToString() async {
    if (sigController.isNotEmpty) {
      final Uint8List? data =
          await sigController.toPngBytes(height: 1000, width: 1000);
      if (data == null) {
        return;
      }
      final String base64String = base64Encode(data);
      signature = base64String;

      setState();
    }
  }

  Future<void> downloadSignature(String base64String) async {
    try {
      final Uint8List bytes = base64Decode(base64String);

      // Create a blob from the bytes
      final blob = html.Blob([bytes]);

      // Create a URL for the blob
      final url = html.Url.createObjectUrlFromBlob(blob);

      // Create an anchor element to trigger download
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', '$empName.signature.png')
        ..click();

      // Clean up
      html.Url.revokeObjectUrl(url);
    } catch (e) {
      log('Error downloading signature: $e');
    }
  }

// Modified widget with download button
  Widget signatureToImage(String base64String) {
    try {
      final Uint8List bytes = base64Decode(base64String);
      return Column(
        children: [
          Image.memory(
            bytes,
            width: 200,
            height: 200,
            fit: BoxFit.fill,
            scale: 20,
          ),
          ElevatedButton(
            onPressed: () => downloadSignature(base64String),
            child: const Text('Download Signature'),
          ),
        ],
      );
    } catch (e) {
      return const Text('Invalid signature data');
    }
  }

  // Modified widget with download button
  Widget signatureToImageForGuest(String base64String) {
    try {
      final Uint8List bytes = base64Decode(base64String);
      return Column(
        children: [
          Image.memory(
            bytes,
            width: 200,
            height: 200,
            fit: BoxFit.fill,
            scale: 20,
          ),
          // ElevatedButton(
          //   onPressed: () => downloadSignature(base64String),
          //   child: const Text('Download Signature'),
          // ),
        ],
      );
    } catch (e) {
      return const Text('Invalid signature data');
    }
  }

  Future<void> saveData(BuildContext context) async {
    try {
      loading.showLoading(context);
      await convertSignatureToString();
      final forIdModel = ForIdModel(
          id: '',
          empNo: empNoController.text,
          empName: empNameController.text,
          empDept: empDept,
          ecName: ecNameController.text,
          position: empPositionController.text,
          ecAdd: ecAddController.text,
          ecPhone: ecPhoneController.text,
          signature: signature,
          status: status);

      await dbForId.saveForID(forIdModel);
      if (context.mounted) {
        clearControllers();
        sigController.clear();
        clearForIdModel();
        Navigator.pop(context);

        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Record saved 🫡',
              style: titleStyle,
            ),
          ),
        );
      }

      setState();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              e.toString(),
              style: titleStyle,
            ),
          ),
        );
      }
    }
  }

  Future<void> updateData(BuildContext context, String documentId) async {
    try {
      loading.showLoading(context);
      await convertSignatureToString();
      final updateForIdModel = ForIdModel(
          id: documentId,
          empNo: empNoController.text,
          empName: empNameController.text,
          empDept: empDept,
          ecName: ecNameController.text,
          position: empPositionController.text,
          ecAdd: ecAddController.text,
          ecPhone: ecPhoneController.text,
          signature: signature,
          status: status);

      await dbForId.updateForID(documentId, updateForIdModel);
      if (context.mounted) {
        clearControllers();
        clearForIdModel();

        Navigator.pop(context);

        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Record updated 🫡',
              style: titleStyle,
            ),
          ),
        );
      }

      setState();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              e.toString(),
              style: titleStyle,
            ),
          ),
        );
      }
    }
  }

  Future<void> deleteData(BuildContext context, String documentId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to delete this? 🌙'),
          content: const SingleChildScrollView(),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                try {
                  loading.showLoading(context);

                  final updateForIdModel = ForIdModel(
                      id: documentId,
                      empNo: '',
                      empName: '',
                      empDept: '',
                      ecName: '',
                      position: '',
                      ecAdd: '',
                      ecPhone: '',
                      signature: '',
                      status: '');

                  await dbForId.deleteForID(updateForIdModel.id);
                  if (context.mounted) {
                    clearControllers();
                    clearForIdModel();
                    Navigator.pop(context);

                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Record deleted 🫡',
                          style: titleStyle,
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  }

                  setState();
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          e.toString(),
                          style: titleStyle,
                        ),
                      ),
                    );
                  }
                }
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
  // Future<void> updateData(BuildContext context, String documentId) async {
  //   try {
  //     await convertSignatureToString();
  //     final updatedForIdModel = ForIdModel(
  //       id: documentId,
  //       empNo: empNoController.text,
  //       empName: empNameController.text,
  //       empDept: empDept,
  //       ecName: ecNameController.text,
  //       status: status,
  //       signature: signature,
  //     );
  //     await dbForId.updateForID(documentId, updatedForIdModel);
  //     if (context.mounted) {
  //       Navigator.pop(context);
  //       clearControllers();
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Record updated ^_^')),
  //       );
  //     }
  //     setState();
  //   } catch (e) {
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Error: $e')),
  //       );
  //     }
  //   }
  // }

  ForIdModel clearForIdModel() {
    return const ForIdModel(
        id: '',
        ecAdd: '',
        empNo: '',
        empDept: '',
        empName: '',
        ecName: '',
        ecPhone: '',
        status: '',
        signature: '',
        position: '');
  }

  //clear controllers  for text fields
  void clearControllers() {
    clearForIdModel();
    empNoController.clear();
    empPositionController.clear();
    empNameController.clear();
    ecNameController.clear();
    ecAddController.clear();
    ecPhoneController.clear();
    sigController.clear();
    setState();
  }
}
