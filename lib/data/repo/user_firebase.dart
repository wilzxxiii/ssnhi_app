// //all user calls and firebase calls
// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:ssnhi_app/data/models/user_model.dart';

// class UserFirebaseRepository {
//   UserFirebaseRepository({FirebaseAuth? firebaseAuth})
//       : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

//   final FirebaseAuth _firebaseAuth;
//   final _userCollection = FirebaseFirestore.instance.collection('users');

//   Stream<User?> get user {
//     return _firebaseAuth.authStateChanges().map((firebaseUser) {
//       final user = firebaseUser;
//       return user;
//     });
//   }

//   Future<void> logOut() async {
//     try {
//       await _firebaseAuth.signOut();
//     } catch (e) {
//       log(e.toString());
//       rethrow;
//     }
//   }

//   // @override
//   Future<void> signIn(String email, String password) async {
//     await _firebaseAuth.signInWithEmailAndPassword(
//         email: email, password: password);
//     // try {

//     // } catch (e) {
//     //   log(e.toString());
//     //   rethrow;
//     // }
//   }

//   // @override
//   Future<MyUser> signUp(
//     MyUser myUser,
//     String password,
//   ) async {
//     try {
//       UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
//           email: myUser.email, password: password);

//       myUser = myUser.copyWith(id: user.user!.uid);
//       await _userCollection.doc(user.user!.uid).set(myUser.toEntity().toJson());
//       await _firebaseAuth.currentUser!.sendEmailVerification();
//       return myUser;
//     } catch (e) {
//       log(e.toString());
//       rethrow;
//     }
//   }

//   // @override
//   Future<void> resetPassword(String email) async {
//     try {
//       await _firebaseAuth.sendPasswordResetEmail(email: email);
//     } catch (e) {
//       log(e.toString());
//       rethrow;
//     }
//   }

//   // @override
//   Future<MyUser> getMyUser(String myUserId) {
//     try {
//       return _userCollection
//           .doc(myUserId)
//           .get()
//           .then((value) => MyUser.fromEntity(MyUser.fromJson(value.data()!)));
//       // await _userCollection.doc(user.id).set(user.toEntity().toJson());
//     } catch (e) {
//       log(e.toString());
//       rethrow;
//     }
//   }

//   // @override
//   Future<void> setUserData(MyUser user) async {
//     try {
//       await _userCollection.doc(user.id).set(user.toEntity().toJson());
//     } catch (e) {
//       log(e.toString());
//       rethrow;
//     }
//   }
// }
