import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:june/june.dart';
import 'package:ssnhi_app/June/sign_in_june/sign_in_june.dart';
import 'package:ssnhi_app/screens/authentication/sign%20up/sign_up.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

class SigninForm extends StatelessWidget {
  const SigninForm({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailCtrl = TextEditingController();
    final TextEditingController passwordCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    // final firebaseRepo = UserFirebaseRepository();

    return Form(
      key: formKey,
      child: JuneBuilder(
        () => SignInJune.instance,
        builder: (vm) => SizedBox(
          height: 400,
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
                // onChanged: (val) {
                //   June.getState(SignInJune.instance.emailValue(emailCtrl.text));
                // },
                onChanged: (val) =>
                    SignInJune.instance.emailValue(emailCtrl.text),

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
                obscureText: SignInJune.instance.obscured,
                controller: passwordCtrl,
                validator: MinLengthValidator(8,
                        errorText: 'Password should be atleast 8 characters')
                    .call,
                onChanged: (val) =>
                    SignInJune.instance.passwordValue(passwordCtrl.text),
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
                        SignInJune.instance.viewPassword();
                      },
                      icon: const Icon(Icons.remove_red_eye)),
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () async {
                  // if (formKey.currentState!.validate()) {
                  //   try {
                  //     await firebaseRepo
                  //         .signIn(emailCtrl.text, passwordCtrl.text)
                  //         .then((value) {
                  //       emailCtrl.dispose();
                  //       passwordCtrl.dispose();
                  //       if (context.mounted) {
                  //         Navigator.pushReplacement(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => const UserChecker()));
                  //       }
                  //     });
                  //   } on FirebaseAuthException catch (e) {
                  //     if (context.mounted) {
                  //       ToastService.showToast(
                  //         context,
                  //         isClosable: true,
                  //         backgroundColor: Colors.red,
                  //         shadowColor: Colors.teal.shade200,
                  //         length: ToastLength.medium,
                  //         expandedHeight: 100,
                  //         message: e.toString(),
                  //         leading: const Icon(Icons.error),
                  //         slideCurve: Curves.elasticInOut,
                  //         positionCurve: Curves.bounceOut,
                  //         dismissDirection: DismissDirection.none,
                  //       );
                  //     }
                  //   }
                  // } else {
                  //   ToastService.showToast(
                  //     context,
                  //     isClosable: true,
                  //     backgroundColor: Colors.red,
                  //     shadowColor: Colors.teal.shade200,
                  //     length: ToastLength.medium,
                  //     expandedHeight: 100,
                  //     message: "Form is invalid",
                  //     leading: const Icon(Icons.error),
                  //     slideCurve: Curves.elasticInOut,
                  //     positionCurve: Curves.bounceOut,
                  //     dismissDirection: DismissDirection.none,
                  //   );
                  // }
                },
                child: const Text(
                  'Log in',
                  style: titleStyleDark,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: titleStyleDark,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()));
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
      ),
    );
  }
}
