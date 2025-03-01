import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:june/june.dart';
import 'package:signature/signature.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_db_service.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_model.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:ssnhi_app/users/screens/loading_screen.dart';

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

  bool canEdit = false;
  void goEdit() {
    canEdit = !canEdit;
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

  Widget signatureToImage(String base64String) {
    try {
      final Uint8List bytes = base64Decode(base64String);
      return Image.memory(
        bytes,
        width: 300, // Adjust size as needed
        height: 300, // Adjust size as needed
        fit: BoxFit.contain, // Preserve aspect ratio
        scale: 20,
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
        Navigator.pop(context);
        clearControllers();
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Record saved ^_^',
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
        Navigator.pop(context);
        clearControllers();
        clearForIdModel();
        canEdit = false;
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Record updated ^_^',
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
        Navigator.pop(context);
        clearControllers();
        clearForIdModel();
        canEdit = false;
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Record deleted ^_^',
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
    empNoController.clear();
    empPositionController.clear();
    empNameController.clear();
    ecNameController.clear();
    ecAddController.clear();
    ecPhoneController.clear();
    sigController.clear();
    clearForIdModel();
    setState();
  }
}
