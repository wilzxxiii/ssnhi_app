import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:june/june.dart';
import 'package:ssnhi_app/June/sign_in_june/sign_in_june.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:ssnhi_app/shared/utils/responsive.dart';

class SigninForm extends StatelessWidget {
  const SigninForm({super.key});

  @override
  Widget build(BuildContext context) {
    //

    final TextEditingController emailCtrl = TextEditingController();
    final TextEditingController passwordCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Padding(
      // padding: const EdgeInsets.all(20.0),
      padding: Responsive.isDesktop(context)
          ? const EdgeInsets.all(100)
          : const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: JuneBuilder(
          () => SignInJune.instance,
          builder: (vm) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'SIGN IN KA DAW MUNA ',
                style: titleText,
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
                decoration: const InputDecoration(
                  label: Text('E-mail address'),
                  prefixIcon: Icon(Icons.email),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, style: BorderStyle.solid),
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
                  contentPadding: const EdgeInsets.all(20),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 10, style: BorderStyle.solid),
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
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    print('form valid');
                    // SignInJune.instance.dispose();
                    // passwordCtrl.dispose();
                    // emailCtrl.dispose();
                    // print(vm.email);
                  } else {
                    print('form invalid');
                  }
                },
                child: const Text(
                  'Log in',
                  style: titleText,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
