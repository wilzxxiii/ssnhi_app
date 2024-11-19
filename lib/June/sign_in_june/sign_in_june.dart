import 'package:june/state_manager/src/simple/controllers.dart';

class SignInJune extends JuneState {
  static final SignInJune instance = SignInJune._privateConstructor();

  bool obscured = true;
  String? email;
  String? password;

  SignInJune._privateConstructor();

  @override
  void dispose() {
    password = '';
    email = '';
    setState();
    super.dispose();
  }

  viewPassword() {
    obscured = !obscured;
    setState();
  }

  emailValue(String email) {
    this.email = email;
    setState();
  }

  passwordValue(String password) {
    this.password = password;
    setState();
  }
}
