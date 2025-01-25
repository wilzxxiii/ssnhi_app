import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ssnhi_app/data/user/model/user_model.dart';

class UserDatabaseService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  // Save user data to Firestore
  Future<void> saveUserData(MyUserModel myUserModel) async {
    try {
      await userCollection.doc(myUserModel.userId).set(myUserModel.toMap());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<MyUserModel?> getUserData(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await userCollection
          .doc(userId)
          .get() as DocumentSnapshot<Map<String, dynamic>>;
      if (snapshot.exists) {
        return MyUserModel.fromMap(snapshot.data()!);
      }
      return null; // User not found
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // Update user data
  Future<void> updateUserData(String userId, Map<String, dynamic> data) async {
    try {
      await userCollection.doc(userId).update(data);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // Stream user data for real-time updates
  Stream<MyUserModel> userDataStream(String userId) {
    return userCollection.doc(userId).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return MyUserModel.fromMap(snapshot.data()! as Map<String, dynamic>);
      } else {
        throw Exception("User data not found");
      }
    });
  }
}
