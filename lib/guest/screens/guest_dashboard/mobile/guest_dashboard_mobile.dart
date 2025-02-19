import 'package:flutter/material.dart';
import 'package:ssnhi_app/users/screens/authentication/sign%20in/sign_in.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:universal_html/html.dart' as html;

class GuestDashboarMobile extends StatelessWidget {
  const GuestDashboarMobile({super.key});

  void _openInNewTab(String url) {
    html.window.open(url,
        'https://echow.xyz/user/0xa5e2460c562438a47f385322b8e1108A4DC788a9');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        hoverColor: hoverColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SigninPage(),
            ),
          );
        },
        backgroundColor: mainColor,
        label: const Text(
          'Sign in ✨',
          style: titleStyle,
        ),
      ),
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
              color: Colors.black,
              child: Center(
                child: Column(
                  children: [
                    const Text(
                      'Copyright © 2025. Brando, All Rights Reserved. Support the dev by buying his art here: ',
                      style: titleStyle,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                          onPressed: () {
                            _openInNewTab(
                                'https://echow.xyz/user/0xa5e2460c562438a47f385322b8e1108A4DC788a9');
                          },
                          child: const Text(
                            'Echow.xyz',
                            style: titleStyle,
                          )),
                    )
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
