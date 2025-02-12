import 'dart:developer';
import 'package:june/june.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ssnhi_app/data/user/model/user_model.dart';

class AuthState extends JuneState {
  MyUserModel? _user;
  final _firestore = FirebaseFirestore.instance;

  MyUserModel? get user => _user;

  // Constructor initializes the state
  AuthState() {
    _initializeAuthListener();
    setState();
  }

  void _initializeAuthListener() {
    FirebaseAuth.instance.authStateChanges().listen((firebaseUser) async {
      if (firebaseUser == null) {
        _user = null;
        setState();
      } else {
        await firebaseUser.reload();
        _fetchAndUpdateUser(firebaseUser);

        setState();
      }
      setState(); // Notify listeners that the state has changed
    }, onError: (error) {
      log('AuthState listener error: $error');
    });
  }

  Future<void> _fetchAndUpdateUser(User firebaseUser) async {
    try {
      final doc =
          await _firestore.collection('users').doc(firebaseUser.uid).get();
      if (doc.exists) {
        _user = MyUserModel.fromMap({
          ...doc.data()!,
          'userId': firebaseUser.uid,
          'email': firebaseUser.email ?? "",
          'emailVerified': firebaseUser.emailVerified, //
        });

        setState();
      } else {
        _user = MyUserModel(
          userId: firebaseUser.uid,
          email: firebaseUser.email ?? "",
          name: firebaseUser.displayName ?? "Unknown",
          emailVerified: firebaseUser
              .emailVerified, // // Fallback to Firebase if not in Firestore
        );
        setState();
        // Optionally, you might want to save this new user to Firestore here
      }
    } catch (e) {
      log('Error fetching user data: $e');
      // Fallback to only firebase data if Firestore fetch fails
      _user = MyUserModel(
        userId: firebaseUser.uid,
        email: firebaseUser.email ?? "",
        name: firebaseUser.displayName ?? "Unknown",
        emailVerified: firebaseUser.emailVerified, //
      );
      setState();
    }
  }

  void updateUser(MyUserModel userDetails) {
    _user = userDetails;
    setState(); // Notify listeners
  }

  void clearUser() {
    _user = null;
    setState(); // Notify listeners
  }
}
