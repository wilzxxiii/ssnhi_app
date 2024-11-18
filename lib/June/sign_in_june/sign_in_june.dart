import 'package:june/state_manager/src/simple/controllers.dart';

class SignInJune extends JuneState {
  static bool obscured = true;
  String email;
  String passsword;

  SignInJune({
    required this.email,
    required this.passsword,
  });

  viewPassword() {
    obscured != obscured;
    setState();
  }

  emailValue(String email) {
    email = email;
    setState();
  }

  passwordValue(String password) {
    password = password;
    setState();
  }
}
