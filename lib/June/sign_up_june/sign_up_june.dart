import 'package:june/state_manager/src/simple/controllers.dart';

class SignUpJune extends JuneState {
  static final SignUpJune instance = SignUpJune._privateConstructor();

  bool obscured = true;
  String? email;
  String? name;
  String? passsword;
  String? confirmPassword;

  SignUpJune._privateConstructor();

  void viewPassword() {
    obscured = !obscured;
    setState();
  }

  void emailValue(String email) {
    this.email = email;
    setState();
  }

  void passwordValue(String password) {
    this.passsword = password;
    setState();
  }

  void confirmPasswordValue(String confirmPassword) {
    this.confirmPassword = confirmPassword;
    setState();
  }
}
