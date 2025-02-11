import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:june/june.dart';
import 'package:signature/signature.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_db_service.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_model.dart';

class ForIdFormVM extends JuneState {
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

  //Signature Controller
  //Signature controller
  final SignatureController sigController = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
    exportPenColor: Colors.black,
  );

  Future<void> saveData() async {
    try {
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
}
