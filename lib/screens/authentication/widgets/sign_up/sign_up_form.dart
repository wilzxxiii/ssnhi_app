import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:ssnhi_app/shared/utils/responsive.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    //

    return Padding(
      padding: Responsive.isDesktop(context)
          ? const EdgeInsets.all(100)
          : const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'REGISTER KA DAW MUNA',
            style: titleText,
          ),
          const SizedBox(height: 20),
          TextFormField(
            // validator: EmailValidator(
            //         errorText: 'Valid e-mail dapat yare ka kay sir dan')
            //     .call,
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
            obscureText: true,
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
                  onPressed: () {}, icon: const Icon(Icons.remove_red_eye)),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {},
                child: const Text(
                  'Register',
                  style: subtitleText,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: subtitleText,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
