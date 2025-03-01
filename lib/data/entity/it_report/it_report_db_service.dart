import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ssnhi_app/data/entity/it_report/it_report_model.dart';

class ItReportDbService {
  final CollectionReference itReportCollection =
      FirebaseFirestore.instance.collection('it-report-form');

  // Save  to Firestore
  Future<void> saveForID(ItReportModel itReportModel) async {
    try {
      // Add the document and get the DocumentReference
      DocumentReference docRef =
          await itReportCollection.add(itReportModel.toMap());

      // Update the document with its own ID
      await docRef.update({'id': docRef.id});
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // Read: Get a specific ForIdModel by its document ID
  Future<ItReportModel?> getForID(String documentId) async {
    try {
      final docSnapshot = await itReportCollection.doc(documentId).get();
      if (docSnapshot.exists) {
        return ItReportModel.fromMap(
            docSnapshot.data() as Map<String, dynamic>);
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
  Future<List<ItReportModel>> getAllForIDs() async {
    try {
      final querySnapshot = await itReportCollection.get();
      return querySnapshot.docs
          .map((doc) =>
              ItReportModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('Error retrieving all ForIDs: $e');
      rethrow;
    }
  }

  // Update: Update an existing ForIdModel by its document ID
  Future<void> updateForID(
      String documentId, ItReportModel updatedForIdModel) async {
    try {
      await itReportCollection
          .doc(documentId)
          .update(updatedForIdModel.toMap());
      log('ForID updated successfully for ID: $documentId');
    } catch (e) {
      log('Error updating ForID: $e');
      rethrow;
    }
  }

  // Delete: Delete a ForIdModel by its document ID
  Future<void> deleteForID(String documentId) async {
    try {
      await itReportCollection.doc(documentId).delete();
      log('ForID deleted successfully for ID: $documentId');
    } catch (e) {
      log('Error deleting ForID: $e');
      rethrow;
    }
  }

  // Optional: Stream for real-time updates of a specific ForIdModel
  Stream<ItReportModel?> getForIDStream(String documentId) {
    return itReportCollection.doc(documentId).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return ItReportModel.fromMap(snapshot.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    });
  }

  Stream<List<ItReportModel>> getAllForIDsStream() {
    return itReportCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ItReportModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    }).handleError((error) {
      throw error; // Pass to onError in listen
    });
  }
}
