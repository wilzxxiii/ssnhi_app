import 'package:flutter/material.dart';
import 'package:ssnhi_app/users/screens/authentication/sign%20in/sign_in.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:universal_html/html.dart' as html;

class GuestDashboardWeb extends StatelessWidget {
  const GuestDashboardWeb({super.key});

  void _openInNewTab(String url) {
    html.window.open(url,
        'https://echow.xyz/user/0xa5e2460c562438a47f385322b8e1108A4DC788a9');
  }

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
        child: Column(
          children: [
            Container(
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
            Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              height: 70,
              color: Colors.black,
              child: Center(
                child: Row(
                  children: [
                    const Text(
                      'Copyright © 2025. Brando, All Rights Reserved. Support the dev by buying his art here: ',
                      style: titleStyle,
                    ),
                    TextButton(
                        onPressed: () {
                          _openInNewTab(
                              'https://echow.xyz/user/0xa5e2460c562438a47f385322b8e1108A4DC788a9');
                        },
                        child: const Text(
                          'Echow.xyz',
                          style: titleStyle,
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
