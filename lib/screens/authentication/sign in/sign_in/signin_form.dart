import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:ssnhi_app/app_status.dart';
import 'package:ssnhi_app/data/user/auth/user_firebase.dart';
import 'package:ssnhi_app/screens/authentication/sign%20up/sign_up.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toast_service.dart';

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
  final authService = AuthService();

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
              validator: MinLengthValidator(8,
                      errorText: 'Password should be atleast 8 characters')
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
                // June.getState(() => AppState()).startLoading();

                if (formKey.currentState!.validate()) {
                  try {
                    await authService
                        .signInUser(emailCtrl.text, passwordCtrl.text)
                        .then((value) {
                      if (context.mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AppStateCheck(),
                          ),
                        ).then((_) {
                          emailCtrl.dispose();
                          passwordCtrl.dispose();
                        });
                      }
                    });
                  } on FirebaseAuthException catch (e) {
                    if (context.mounted) {
                      ToastService.showToast(
                        context,
                        isClosable: true,
                        backgroundColor: Colors.red,
                        shadowColor: Colors.teal.shade200,
                        length: ToastLength.medium,
                        expandedHeight: 100,
                        message: e.toString(),
                        leading: const Icon(Icons.error),
                        slideCurve: Curves.elasticInOut,
                        positionCurve: Curves.bounceOut,
                        dismissDirection: DismissDirection.none,
                      );
                    }
                  }
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
