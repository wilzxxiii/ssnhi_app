import 'package:june/state_manager/src/simple/controllers.dart';

class SignUpJune extends JuneState {
  static final SignUpJune instance = SignUpJune._privateConstructor();

  bool passwordObs = true;
  bool confirmPasswordObs = true;
  String? email;
  String? name;
  String? password;
  String? confirmPassword;

  SignUpJune._privateConstructor();

  void viewPassword() {
    passwordObs = !passwordObs;
    setState();
  }

  void viewConfirmPassword() {
    confirmPasswordObs = !confirmPasswordObs;
    setState();
  }

  void nameValue(String name) {
    this.name = name;
    setState();
  }

  void emailValue(String email) {
    this.email = email;
    setState();
  }

  void passwordValue(String password) {
    this.password = password;
    setState();
  }

  void confirmPasswordValue(String confirmPassword) {
    this.confirmPassword = confirmPassword;
    setState();
  }

  void disposeSignUp() {
    email = "";
    name = "";
    password = '';
    confirmPassword = '';
    super.dispose();
  }
}
