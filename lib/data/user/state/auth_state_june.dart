import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:june/june.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ssnhi_app/data/user/auth/user_firebase.dart';
import 'package:ssnhi_app/data/user/model/user_model.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:ssnhi_app/user_check.dart';
import 'package:ssnhi_app/users/screens/loading_screen.dart';

class AuthState extends JuneState {
  MyUserModel? _user;
  final _firestore = FirebaseFirestore.instance;
  final _userAuth = AuthService();

  MyUserModel? get user => _user;

  final loadingScreen = LoadingScreen();
  bool isLoading = true;
  // Constructor initializes the state
  AuthState() {
    _initializeAuthListener();
  }

  void _initializeAuthListener() {
    FirebaseAuth.instance.authStateChanges().listen((firebaseUser) async {
      if (firebaseUser != null) {
        await firebaseUser.reload();

        await _fetchAndUpdateUser(firebaseUser);

        // updateUserEmailVerification();
        isLoading = false;
        setState();
      } else {
        _user = null;

        isLoading = false;
        setState();
      }
      // Notify listeners that the state has changed
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
          'emailVerified': firebaseUser.emailVerified,
        });

        setState();
      } else {
        _user = MyUserModel(
          userId: firebaseUser.uid,
          email: firebaseUser.email ?? "",
          name: firebaseUser.displayName ?? "Unknown",
          emailVerified: firebaseUser.emailVerified,
        );

        setState();
      }
    } catch (e) {
      log('Error fetching user data: $e');
      _user = MyUserModel(
        userId: firebaseUser.uid,
        email: firebaseUser.email ?? "",
        name: firebaseUser.displayName ?? "Unknown",
        emailVerified: firebaseUser.emailVerified,
      );
    }
  }

  Future<void> userLogin(
      String email, String password, BuildContext context) async {
    try {
      loadingScreen.showLoading(context);
      await _userAuth.signInUser(email, password);
      await _fetchAndUpdateUser(FirebaseAuth.instance.currentUser!);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: darkBackground,
              content: Text(
                'Logged in successfully 🌙',
                style: titleStyle,
              )),
        );
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const UserChecker(),
            ),
            (r) => false);
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                'Login failed: $e 💀',
                style: titleStyle,
              )),
        );
      }
    }
  }

  Future<void> userRegister(
      MyUserModel? newUser, String password, BuildContext context) async {
    try {
      loadingScreen.showLoading(context);

      await _userAuth.signUpUser(newUser!, password);
      await _fetchAndUpdateUser(FirebaseAuth.instance.currentUser!);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: darkBackground,
              content: Text(
                'Registered successfully 🌙',
                style: titleStyle,
              )),
        );
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const UserChecker(),
            ),
            (r) => false);
      }
    } catch (e) {
      log(e.toString());
      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                'Can not register: $e 💀',
                style: titleStyle,
              )),
        );
      }
    }
  }

  Future<void> userLogOut(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to log out cutie? 🌙'),
          content: const SingleChildScrollView(),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                try {
                  loadingScreen.showLoading(context);
                  await _userAuth.logOut();

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.black,
                        content: Text(
                          'Please come back. ✨',
                          style: titleStyle,
                        ),
                      ),
                    );

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserChecker(),
                        ),
                        (r) => false);
                  }
                } catch (e) {
                  log(e.toString());
                  if (context.mounted) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          'Unable to logout: $e 💀',
                          style: titleStyle,
                        ),
                      ),
                    );
                  }
                } finally {
                  clearUser();
                }
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    // try {
    //   loadingScreen.showLoading(context);
    //   await _userAuth.logOut();
    //   if (context.mounted) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(
    //         backgroundColor: Colors.black,
    //         content: Text(
    //           'Please come back. ✨',
    //           style: titleStyle,
    //         ),
    //       ),
    //     );

    //     Navigator.pushAndRemoveUntil(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => const UserChecker(),
    //         ),
    //         (r) => false);
    //   }
    // } catch (e) {
    //   log(e.toString());
    //   if (context.mounted) {
    //     Navigator.of(context).pop();
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         backgroundColor: Colors.red,
    //         content: Text(
    //           'Unable to logout: $e 💀',
    //           style: titleStyle,
    //         ),
    //       ),
    //     );
    //   }
    // } finally {
    //   clearUser();
    // }
  }

  void clearUser() {
    _user = null;
    setState(); // Notify listeners
  }
}
