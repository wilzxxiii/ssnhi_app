import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_model.dart';

class ForIdDbService {
  final CollectionReference forIdCollection =
      FirebaseFirestore.instance.collection('forId');

  // Save user data to Firestore
  Future<void> saveForID(ForIdModel forIdModel) async {
    try {
      // Add the document and get the DocumentReference
      DocumentReference docRef = await forIdCollection.add(forIdModel.toMap());

      // Update the document with its own ID
      await docRef.update({'id': docRef.id});
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // Read: Get a specific ForIdModel by its document ID
  Future<ForIdModel?> getForID(String documentId) async {
    try {
      final docSnapshot = await forIdCollection.doc(documentId).get();
      if (docSnapshot.exists) {
        return ForIdModel.fromMap(docSnapshot.data() as Map<String, dynamic>);
      } else {
        log('ForID with ID $documentId does not exist');
        return null;
      }
    } catch (e) {
      log('Error retrieving ForID: $e');
      rethrow;
    }
  }

  // Read: Get all ForIdModels from Firestore
  Future<List<ForIdModel>> getAllForIDs() async {
    try {
      final querySnapshot = await forIdCollection.get();
      return querySnapshot.docs
          .map((doc) => ForIdModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('Error retrieving all ForIDs: $e');
      rethrow;
    }
  }

  // Update: Update an existing ForIdModel by its document ID
  Future<void> updateForID(
      String documentId, ForIdModel updatedForIdModel) async {
    try {
      await forIdCollection.doc(documentId).update(updatedForIdModel.toMap());
      log('ForID updated successfully for ID: $documentId');
    } catch (e) {
      log('Error updating ForID: $e');
      rethrow;
    }
  }

  // Delete: Delete a ForIdModel by its document ID
  Future<void> deleteForID(String documentId) async {
    try {
      await forIdCollection.doc(documentId).delete();
      log('ForID deleted successfully for ID: $documentId');
    } catch (e) {
      log('Error deleting ForID: $e');
      rethrow;
    }
  }

  // Optional: Stream for real-time updates of a specific ForIdModel
  Stream<ForIdModel?> getForIDStream(String documentId) {
    return forIdCollection.doc(documentId).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return ForIdModel.fromMap(snapshot.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    });
  }

  Stream<List<ForIdModel>> getAllForIDsStream() {
    return forIdCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ForIdModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    }).handleError((error) {
      throw error; // Pass to onError in listen
    });
  }
}
