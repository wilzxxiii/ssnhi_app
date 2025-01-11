import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:june/june.dart';
import 'package:ssnhi_app/June/sign_up_june/sign_up_june.dart';

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
    // final userFirebaseRepository = UserFirebaseRepository();

    return Form(
      key: formKey,
      child: JuneBuilder(
        () => SignUpJune.instance,
        builder: (vm) => SizedBox(
          height: 400,
          width: 500,
          child: Column(
            children: [
              const Text('REGISTER ACCOUNT',
                  style: TextStyle(
                    fontSize: 22,
                  )),
              const SizedBox(height: 20),
              TextFormField(
                controller: nameCtrl,
                onChanged: (val) =>
                    SignUpJune.instance.nameValue(nameCtrl.text),
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
                onChanged: (val) =>
                    SignUpJune.instance.emailValue(emailCtrl.text),
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide:
                        const BorderSide(width: 10, style: BorderStyle.solid),
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
                  border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 10, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(20.0),
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
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.black, //<-- SEE HERE
                    ),
                    onPressed: () async {
                      // if (formKey.currentState!.validate()) {
                      //   if (confirmPasswordCtrl.text != passwordCtrl.text) {
                      //     ToastService.showToast(
                      //       context,
                      //       isClosable: true,
                      //       backgroundColor: Colors.red,
                      //       shadowColor: Colors.teal.shade200,
                      //       length: ToastLength.medium,
                      //       expandedHeight: 100,
                      //       message: 'Password does not match',
                      //       leading: const Icon(Icons.error),
                      //       slideCurve: Curves.elasticInOut,
                      //       positionCurve: Curves.bounceOut,
                      //       dismissDirection: DismissDirection.none,
                      //     );
                      //   } else {
                      //     // try {
                      //     //   MyUser myUser = MyUser.empty;
                      //     //   myUser = myUser.copyWith(
                      //     //     email: emailCtrl.text,
                      //     //     name: nameCtrl.text,
                      //     //   );

                      //     //   userFirebaseRepository.signUp(
                      //     //       myUser, confirmPasswordCtrl.text);
                      //     //   Navigator.pushReplacement(
                      //     //       context,
                      //     //       MaterialPageRoute(
                      //     //           builder: (context) =>
                      //     //               const UserChecker()));
                      //     } on FirebaseAuthException catch (e) {
                      //       ToastService.showToast(
                      //         context,
                      //         isClosable: true,
                      //         backgroundColor: Colors.teal.shade500,
                      //         shadowColor: Colors.teal.shade200,
                      //         length: ToastLength.medium,
                      //         expandedHeight: 100,
                      //         message: e.toString(),
                      //         leading: const Icon(Icons.messenger),
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
                      //     message: 'Form not valid',
                      //     leading: const Icon(Icons.messenger),
                      //     slideCurve: Curves.elasticInOut,
                      //     positionCurve: Curves.bounceOut,
                      //     dismissDirection: DismissDirection.none,
                      //   );
                      // }
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
                      // emailCtrl.dispose();
                      // nameCtrl.dispose();
                      // passwordCtrl.dispose();
                      // confirmPasswordCtrl.dispose();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 20,
                      ),
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
