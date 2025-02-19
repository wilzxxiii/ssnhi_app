import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:ssnhi_app/data/user/database/user_database_service.dart';
import 'package:ssnhi_app/data/user/model/user_model.dart';

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;
  // final _userCollection = FirebaseFirestore.instance.collection('users');
  final userdb = UserDatabaseService();

  Future<void> signInUser(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      // MyUserModel myUserModel = _firebaseAuth.currentUser;
      //  June.getState(() => AuthState()).updateUser(updatedUser);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
    // finally {
    //   loadMe.stopLoading();
    //   print(loadMe.isLoading.toString());
    // }
  }

  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<MyUserModel> signUpUser(MyUserModel newUser, String password) async {
    try {
      // loadMe.startLoading();
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: newUser.email, password: password);

      newUser = newUser.copyWith(
          id: userCredential.user!.uid,
          name: newUser.name,
          email: newUser.email);
      await _firebaseAuth.currentUser!.sendEmailVerification();
      await userdb.saveUserData(newUser);
      return newUser;
    } catch (e) {
      log(e.toString());
      rethrow;
    }

    // finally {
    //   loadMe.stopLoading();
    // }
  }
}

// class UserFirebaseRepository {
//   UserFirebaseRepository({FirebaseAuth? firebaseAuth})
//       : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

//   final FirebaseAuth _firebaseAuth;
//   final _userCollection = FirebaseFirestore.instance.collection('users');

  // Stream<User?> get user {
  //   return _firebaseAuth.authStateChanges().map((firebaseUser) {
  //     final user = firebaseUser;
  //     return user;
  //   });
  // }

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
