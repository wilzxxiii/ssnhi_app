import 'package:june/state_manager/src/simple/controllers.dart';
import 'package:ssnhi_app/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserState extends JuneState {
  MyUserModel? myUserModel;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  UserState(this.myUserModel);

  UserState.initial()
      : myUserModel = const MyUserModel(userId: '', email: '', name: '');

  void updateUser(Map<String, dynamic> changes) {
    myUserModel = MyUserModel.fromMap({
      ...myUserModel!.toMap(),
      ...changes,
    });
    setState();
  }
}
