import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:june/june.dart';

import 'package:ssnhi_app/users/screens/authentication/sign%20up/sign_up.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

import '../../../../../data/user/state/auth_state_june.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({super.key});

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool showPassword = true;
  // final firebaseRepo = UserFirebaseRepository();
  // final authService = AuthService();

  final authState = June.getState(() => AuthState());

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SizedBox(
        height: 500,
        width: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'SIGN IN',
              style: titleStyleDark,
            ),
            // const Spacer(),
            const SizedBox(height: 20),
            TextFormField(
              controller: emailCtrl,
              validator: EmailValidator(
                errorText: 'Please enter a valid email address',
              ).call,
              decoration: InputDecoration(
                label: const Text('E-mail address'),
                prefixIcon: const Icon(Icons.email),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide:
                      const BorderSide(width: 20, style: BorderStyle.solid),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: showPassword,
              controller: passwordCtrl,
              validator: MinLengthValidator(1,
                      errorText: 'Password should not be empty')
                  .call,
              decoration: InputDecoration(
                label: const Text('Password'),
                prefixIcon: const Icon(Icons.password_outlined),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 20, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: showPassword
                        ? const Icon(Icons.remove_red_eye)
                        : const Icon(Icons.visibility_off)),
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.black, //<-- SEE HERE
              ),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await authState.userLogin(
                      emailCtrl.text, passwordCtrl.text, context);
                }
              },
              child: const Text(
                'Log in',
                style: titleStyle,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account?',
                  style: titleStyleDark,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ));
                  },
                  child: const Text(
                    'Sign up',
                    style: TextStyle(color: Colors.blue, fontSize: 22),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
