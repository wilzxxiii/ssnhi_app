import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class AddForIdMobileBody extends StatelessWidget {
  const AddForIdMobileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const Text('REGISTER ACCOUNT',
            //     style: TextStyle(
            //       fontSize: 22,
            //     )),
            const SizedBox(height: 20),
            TextFormField(
              onChanged: (val) {},
              decoration: InputDecoration(
                label: const Text('Name'),
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
              onChanged: (val) {},
              // validator: EmailValidator(
              //         errorText: 'Please enter a valid email address')
              //     .call,
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
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              // controller: confirmPasswordCtrl,

              // onChanged: (val) {},

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
                  onPressed: () async {},
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
    );
  }
}
