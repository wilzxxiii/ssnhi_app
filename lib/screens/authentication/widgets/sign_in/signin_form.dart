import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

class SigninForm extends StatelessWidget {
  const SigninForm({super.key});

  @override
  Widget build(BuildContext context) {
    //

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'SIGN IN KA DAW MUNA ',
            style: titleText,
          ),
          // const Spacer(),
          const SizedBox(height: 20),
          TextFormField(
            validator:
                EmailValidator(errorText: 'Valid e-mail dapat yare ka nanaman'),
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
            decoration: InputDecoration(
              label: const Text('Password'),
              prefixIcon: const Icon(Icons.password_outlined),
              contentPadding: const EdgeInsets.all(20),
              border: const OutlineInputBorder(
                borderSide: BorderSide(width: 10, style: BorderStyle.solid),
              ),
              suffixIcon: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.remove_red_eye)),
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () {},
            child: const Text(
              'Log in',
              style: subtitleText,
            ),
          )
        ],
      ),
    );
  }
}
