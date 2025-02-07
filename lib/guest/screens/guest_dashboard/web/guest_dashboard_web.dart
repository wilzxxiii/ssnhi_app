import 'package:flutter/material.dart';
import 'package:ssnhi_app/users/screens/authentication/sign%20in/sign_in.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

class GuestDashboardWeb extends StatelessWidget {
  const GuestDashboardWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: lightBackground,
        leading: Image.asset('assets/logo.png'),
        title: const Text(
          'Believe in something 🌙',
          style: titleStyleDark,
        ),
        elevation: 5,
        shadowColor: Colors.blue,
        actions: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.black, //<-- SEE HERE
              elevation: 10,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SigninPage()));
            },
            child: const Text(
              'Sign in',
              style: titleStyle,
            ),
          ),
          const SizedBox(
            width: 50,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.orange,
            image: DecorationImage(
                image: AssetImage('assets/brando_black.png'),
                fit: BoxFit.contain),
          ),
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
