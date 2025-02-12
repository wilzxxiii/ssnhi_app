import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:june/june.dart';
import 'package:signature/signature.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_db_service.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_model.dart';

class ForIdState extends JuneState {
  String empNo = '';
  String empName = '';
  String empDept = ''; // No default value since it's now a text field
  String ecName = '';
  String ecAdd = '';
  String ecPhone = '';
  String signature = '';
  String status = 'On Going';
  //My model
  ForIdModel? _forIdModel;

  ForIdModel? get forIdModel => _forIdModel;

  final _dbForId = ForIdDbService();

  //TextEditing Controllers
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // TextEditingController instances for each text field
  final TextEditingController empNoController = TextEditingController();
  final TextEditingController empDepartmentController = TextEditingController();
  final TextEditingController empPositionController = TextEditingController();
  final TextEditingController empNameController = TextEditingController();
  final TextEditingController ecNameController = TextEditingController();
  final TextEditingController ecAddController = TextEditingController();
  final TextEditingController ecPhoneController = TextEditingController();

//
  // Firestore list-related state (from ForIdState)
  List<ForIdModel> forIdList = [];
  bool isLoading = true;
  String? errorMessage;

  //Signature Controller
  forIdState() {
    // Initialize the Firestore stream listener
    _initFirestoreListener();
  }

  // Initialize Firestore stream listener (from ForIdState)
  void _initFirestoreListener() {
    _dbForId.getAllForIDsStream().listen((list) {
      forIdList = list;
      isLoading = false;
      errorMessage = null;
      print('Updated forIdList: ${forIdList.length} items');
      setState(); // Notify listeners to rebuild the UI
    }, onError: (error) {
      isLoading = false;
      errorMessage = error.toString();
      setState(); // Notify listeners to rebuild the UI
    });
  }

  // Optional: Method to pre-fill form with existing data for editing
  void loadForIdModel(ForIdModel model) {
    empNoController.text = model.empNo;
    empNameController.text = model.empName;
    empDepartmentController.text = model.empDept;
    empPositionController.text = model.position;
    ecNameController.text = model.ecName;
    ecAddController.text = model.ecAdd;
    ecPhoneController.text = model.ecPhone;
    signature = model.signature;
    status = model.status;
    _forIdModel = model;
    setState();
  }

  //Signature controller
  final SignatureController sigController = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
    exportPenColor: Colors.black,
  );

  Future<void> saveData() async {
    try {
      if (sigController.isNotEmpty) {
        final Uint8List? data =
            await sigController.toPngBytes(height: 1000, width: 1000);
        if (data == null) {
          // Convert Uint8List to Base64 string

          return;
        }
        final String base64String = base64Encode(data);
        signature = base64String;

        setState();
      }
      final forIdModel = ForIdModel(
          empNo: empNoController.text,
          empName: empNameController.text,
          empDept: empDepartmentController.text,
          ecName: ecNameController.text,
          position: empPositionController.text,
          ecAdd: ecAddController.text,
          ecPhone: ecPhoneController.text,
          signature: signature,
          status: 'On Going');

      await _dbForId.saveForID(forIdModel);
      setState();
    } catch (e) {
      log(e.toString());
    }
  }

  void disposeControllers() {
    empNameController.dispose();
    empDepartmentController.dispose();
    empPositionController.dispose();
    empNoController.dispose();
    ecNameController.dispose();
    ecAddController.dispose();
    ecPhoneController.dispose();
    sigController.dispose();
    super.dispose();
  }

  void clearControllers() {
    empNameController.clear();
    empDepartmentController.clear();
    empPositionController.clear();
    empNoController.clear();
    ecNameController.clear();
    ecAddController.clear();
    ecPhoneController.clear();
    sigController.clear();
    setState();
  }

  ForIdModel clearForIdModel() {
    return const ForIdModel(
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
}
