import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:june/june.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_state.dart';
import 'package:ssnhi_app/users/screens/dashboard/state/dashboard_state.dart';
import 'package:ssnhi_app/users/screens/for_id/for_id_card.dart';

class UserDashboardWebBody extends StatelessWidget {
  const UserDashboardWebBody({super.key});

  @override
  Widget build(BuildContext context) {
    return JuneBuilder(() => DashboardState(), builder: (webState) {
      return Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: const BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
          ),
          child: Center(
            child: webState.moonDashboard
                ? const Text('Dashboard')
                : webState.moonForId
                    ? const ForIdWeb()
                    : webState.moonForItreport
                        ? const Text('For IT')
                        : webState.moonForJo
                            ? const Text('JobOrder')
                            : const Text('Dashboard'),
          ),
        ),
      );
    });
    // return Padding(
    //   padding: const EdgeInsets.only(left: 30, right: 30),
    //   child: Container(
    //     height: MediaQuery.of(context).size.height * 0.8,
    //     decoration: const BoxDecoration(
    //         color: Colors.orange,
    //         borderRadius: BorderRadius.all(Radius.circular(40))),
    //   ),
    // );
  }
}

class ForIdWeb extends StatelessWidget {
  const ForIdWeb({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          width: 20,
        ),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
            color: Colors.white,
          ),
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.3,
        ),
        const SizedBox(
          width: 20,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
            color: Colors.white,
          ),
          child: JuneBuilder(
            () => ForIdState(),
            builder: (forIdState) {
              return forIdState.isLoading
                  ? const Center(
                      child: SpinKitFoldingCube(
                        color: Colors.black,
                      ),
                    )
                  : forIdState.errorMessage != null
                      ? Center(child: Text('Error: ${forIdState.errorMessage}'))
                      : forIdState.forIdList.isEmpty
                          ? const Center(child: Text('No records found'))
                          : ListView.builder(
                              itemCount: forIdState.forIdList.length,
                              itemBuilder: (context, index) {
                                final forId = forIdState.forIdList[index];
                                return ForIdCard(
                                  forId: forId,
                                  vm: forIdState,
                                );
                              },
                            );
            },
          ),
        ),
      ],
    );
  }
}
