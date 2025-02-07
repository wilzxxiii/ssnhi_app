import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ssnhi_app/data/user/model/for_id_model.dart';

class ForIdDbService {
  final CollectionReference forIdCollection =
      FirebaseFirestore.instance.collection('forId');

  // Save user data to Firestore
  Future<void> saveUserData(ForIdModel forIdModel) async {
    try {
      await forIdCollection.add(forIdModel.toMap());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
