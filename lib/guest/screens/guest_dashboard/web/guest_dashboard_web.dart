import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:june/june.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_state.dart';
import 'package:ssnhi_app/guest/charts/maintenance_chart.dart';
import 'package:ssnhi_app/guest/charts/performer_chart.dart';
import 'package:ssnhi_app/guest/charts/request_per_department_chart.dart';
import 'package:ssnhi_app/guest/for_id/guest_for_id.dart';
import 'package:ssnhi_app/guest/for_id/guest_for_id_card.dart';
import 'package:ssnhi_app/users/screens/authentication/sign%20in/sign_in.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:universal_html/html.dart' as html;

class GuestDashboardWeb extends StatefulWidget {
  const GuestDashboardWeb({super.key});

  @override
  State<GuestDashboardWeb> createState() => _GuestDashboardWebState();
}

class _GuestDashboardWebState extends State<GuestDashboardWeb> {
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
                // image: DecorationImage(
                //     image: AssetImage('assets/brando_black.png'),
                //     fit: BoxFit.contain),
              ),
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Container(
                  padding: const EdgeInsets.all(40),
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 columns
                      mainAxisExtent: MediaQuery.of(context).size.height * 0.5,
                      crossAxisSpacing: 16, // Horizontal spacing between cards
                      mainAxisSpacing: 16, // Vertical spacing between cards
                      childAspectRatio: 0.75, // Adjust card height/width ratio
                    ),
                    children: [
                      //Report
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: const MaintenanceCategoryView(),
                      ),
                      //For ID
                      Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'For ID\'s 💫',
                                style: titleStyleDark,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                width: MediaQuery.of(context).size.width,
                                child: JuneBuilder(() => ForIdState(),
                                    builder: (forIdState) {
                                  return forIdState.isLoading
                                      ? const Center(
                                          child: SpinKitFoldingCube(
                                            color: Colors.black,
                                          ),
                                        )
                                      : forIdState.errorMessage != null
                                          ? Center(
                                              child: Text(
                                                  'Error: ${forIdState.errorMessage}'))
                                          : forIdState.forIdList.isEmpty
                                              ? const Center(
                                                  child:
                                                      Text('No records found'))
                                              : ListView.builder(
                                                  itemCount: 4,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final forId = forIdState
                                                        .forIdList[index];
                                                    return GuestForIdCard(
                                                      forId: forId,
                                                      vm: forIdState,
                                                    );
                                                  },
                                                );
                                }),
                              ),
                            ],
                          )),
                      //IT Report
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: const RequestPerDepartments(),
                      ),
                      //To be decided
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: const PerformerChart(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Center(
                child: Row(
                  children: [
                    const Text(
                      'Copyright © 2025. Brando, All Rights Reserved. Buy my art here: ',
                      style: titleStyle,
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white, //<-- SEE HERE
                        elevation: 10,
                      ),
                      onPressed: () {
                        _openInNewTab(
                            'https://echow.xyz/user/0xa5e2460c562438a47f385322b8e1108A4DC788a9');
                      },
                      child: const Text(
                        'Echow.xyz 🌙',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                        ),
                      ),
                    ),
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
