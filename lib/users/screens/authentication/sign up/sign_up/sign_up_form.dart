import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:june/june.dart';
import 'package:ssnhi_app/data/user/model/user_model.dart';
import 'package:ssnhi_app/data/user/state/auth_state_june.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toast_service.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool showPassword = true;
  bool showConfirmPW = true;

  final authState = June.getState(() => AuthState());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 400,
      width: 500,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('REGISTER ACCOUNT',
                style: TextStyle(
                  fontSize: 22,
                )),
            const SizedBox(height: 20),
            TextFormField(
              controller: nameCtrl,
              onChanged: (val) {},
              decoration: InputDecoration(
                label: const Text('Name'),
                prefixIcon: const Icon(Icons.person),
                contentPadding: const EdgeInsets.all(20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide:
                      const BorderSide(width: 20, style: BorderStyle.solid),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: emailCtrl,
              onChanged: (val) {},
              validator: EmailValidator(
                      errorText: 'Please enter a valid email address')
                  .call,
              decoration: InputDecoration(
                label: const Text('E-mail address'),
                prefixIcon: const Icon(Icons.email),
                contentPadding: const EdgeInsets.all(20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide:
                      const BorderSide(width: 10, style: BorderStyle.solid),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordCtrl,
              // onChanged: (val) {},
              obscureText: showPassword,
              validator: MultiValidator([
                MinLengthValidator(8, errorText: 'Password too short.'),
              ]).call,
              decoration: InputDecoration(
                label: const Text('Password'),
                prefixIcon: const Icon(Icons.password_outlined),
                contentPadding: const EdgeInsets.all(20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide:
                      const BorderSide(width: 10, style: BorderStyle.solid),
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
            TextFormField(
              controller: confirmPasswordCtrl,

              // onChanged: (val) {},
              obscureText: showConfirmPW,
              validator: MultiValidator([
                MinLengthValidator(8, errorText: 'Password too short.'),
              ]).call,
              decoration: InputDecoration(
                label: const Text('Confirm Password'),
                prefixIcon: const Icon(Icons.password_outlined),
                contentPadding: const EdgeInsets.all(20),
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 10, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        showConfirmPW = !showConfirmPW;
                      });
                    },
                    icon: showConfirmPW
                        ? const Icon(Icons.remove_red_eye)
                        : const Icon(Icons.visibility_off)),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.black, //<-- SEE HERE
                  ),
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
                        MyUserModel newUser = MyUserModel(
                          userId: "", // This will be updated by the function
                          email: emailCtrl.text,
                          name: nameCtrl.text,
                        );

                        await authState.userRegister(
                            newUser, confirmPasswordCtrl.text, context);
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
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
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
                    style: TextStyle(
                      fontSize: 20,
                      color: mainColor,
                    ),
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
