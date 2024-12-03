import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:june/june.dart';
import 'package:ssnhi_app/June/sign_up_june/sign_up_june.dart';
import 'package:ssnhi_app/data/models/user_model.dart';
import 'package:ssnhi_app/data/repo/user_firebase.dart';
import 'package:ssnhi_app/screens/authentication/user_check.dart';

import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:ssnhi_app/shared/utils/responsive.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toast_service.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    //

    final TextEditingController nameCtrl = TextEditingController();
    final TextEditingController emailCtrl = TextEditingController();
    final TextEditingController passwordCtrl = TextEditingController();
    final TextEditingController confirmPasswordCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final userFirebaseRepository = UserFirebaseRepository();

    return Form(
      key: formKey,
      child: Padding(
        padding: Responsive.isDesktop(context)
            ? const EdgeInsets.all(100)
            : const EdgeInsets.all(20),
        child: JuneBuilder(
          () => SignUpJune.instance,
          builder: (vm) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'REGISTER KA DAW MUNA',
                style: titleText,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nameCtrl,
                onChanged: (val) =>
                    SignUpJune.instance.nameValue(nameCtrl.text),
                decoration: const InputDecoration(
                  label: Text('Name'),
                  prefixIcon: Icon(Icons.person),
                  contentPadding: EdgeInsets.all(20),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 10, style: BorderStyle.solid),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailCtrl,
                onChanged: (val) =>
                    SignUpJune.instance.emailValue(emailCtrl.text),
                validator: EmailValidator(
                        errorText: 'Valid e-mail dapat yare ka kay sir dan')
                    .call,
                decoration: const InputDecoration(
                  label: Text('E-mail address'),
                  prefixIcon: Icon(Icons.email),
                  contentPadding: EdgeInsets.all(20),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 10, style: BorderStyle.solid),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordCtrl,
                onChanged: (val) =>
                    SignUpJune.instance.passwordValue(passwordCtrl.text),
                obscureText: SignUpJune.instance.passwordObs,
                validator: MultiValidator([
                  MinLengthValidator(8, errorText: 'Password too short.'),
                ]).call,
                decoration: InputDecoration(
                  label: const Text('Password'),
                  prefixIcon: const Icon(Icons.password_outlined),
                  contentPadding: const EdgeInsets.all(20),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 10, style: BorderStyle.solid),
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        SignUpJune.instance.viewPassword();
                      },
                      icon: const Icon(Icons.remove_red_eye)),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: confirmPasswordCtrl,
                onChanged: (val) => SignUpJune.instance
                    .confirmPasswordValue(confirmPasswordCtrl.text),
                obscureText: SignUpJune.instance.confirmPasswordObs,
                validator: MultiValidator([
                  MinLengthValidator(8, errorText: 'Password too short.'),
                ]).call,
                decoration: InputDecoration(
                  label: const Text('Confirm Password'),
                  prefixIcon: const Icon(Icons.password_outlined),
                  contentPadding: const EdgeInsets.all(20),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 10, style: BorderStyle.solid),
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        SignUpJune.instance.viewConfirmPassword();
                      },
                      icon: const Icon(Icons.remove_red_eye)),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        if (confirmPasswordCtrl.text != passwordCtrl.text) {
                          ToastService.showToast(
                            context,
                            isClosable: true,
                            backgroundColor: Colors.red,
                            shadowColor: Colors.teal.shade200,
                            length: ToastLength.medium,
                            expandedHeight: 100,
                            message: 'Password does not match',
                            leading: const Icon(Icons.error),
                            slideCurve: Curves.elasticInOut,
                            positionCurve: Curves.bounceOut,
                            dismissDirection: DismissDirection.none,
                          );
                        } else {
                          try {
                            MyUser myUser = MyUser.empty;
                            myUser = myUser.copyWith(
                              email: emailCtrl.text,
                              name: nameCtrl.text,
                            );

                            userFirebaseRepository.signUp(myUser,
                                SignUpJune.instance.confirmPassword.toString());
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const UserChecker()));
                          } on FirebaseAuthException catch (e) {
                            ToastService.showToast(
                              context,
                              isClosable: true,
                              backgroundColor: Colors.teal.shade500,
                              shadowColor: Colors.teal.shade200,
                              length: ToastLength.medium,
                              expandedHeight: 100,
                              message: e.toString(),
                              leading: const Icon(Icons.messenger),
                              slideCurve: Curves.elasticInOut,
                              positionCurve: Curves.bounceOut,
                              dismissDirection: DismissDirection.none,
                            );
                          }
                        }
                      } else {
                        ToastService.showToast(
                          context,
                          isClosable: true,
                          backgroundColor: Colors.red,
                          shadowColor: Colors.teal.shade200,
                          length: ToastLength.medium,
                          expandedHeight: 100,
                          message: 'Form not valid',
                          leading: const Icon(Icons.messenger),
                          slideCurve: Curves.elasticInOut,
                          positionCurve: Curves.bounceOut,
                          dismissDirection: DismissDirection.none,
                        );
                      }
                    },
                    child: const Text(
                      'Register',
                      style: subtitleText,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      emailCtrl.dispose();
                      nameCtrl.dispose();
                      passwordCtrl.dispose();
                      confirmPasswordCtrl.dispose();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: subtitleText,
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
