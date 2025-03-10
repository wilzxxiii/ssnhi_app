import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:june/june.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_state.dart';
import 'package:ssnhi_app/guest/for_id/guest_for_id_card.dart';
import 'package:ssnhi_app/users/screens/for_id/add_for_id/add_for_id.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

class GuestForIdWeb extends StatelessWidget {
  const GuestForIdWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return JuneBuilder(
      () => ForIdState(),
      builder: (vm) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 150,
              right: 150,
            ),
            child: Scaffold(
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddForID(vm: vm)));
                },
                backgroundColor: mainColor,
                hoverColor: hoverColor,
                tooltip: 'Add record',
                label: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              appBar: AppBar(
                iconTheme: const IconThemeData(color: darkIconColor),
                leading: IconButton(
                  onPressed: () {
                    vm.clearForIdModel();
                    vm.clearControllers();

                    // webState.showMoonDashboard();
                    Navigator.pop(context);
                  },
                  icon: const FaIcon(Icons.arrow_back_ios_new),
                ),
                title: const Text(
                  'For ID\'s 💫',
                  style: titleStyleDark,
                ),
                toolbarHeight: 80,
                elevation: 10,
                backgroundColor: Colors.white,
              ),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width * 0.4,
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width * 0.4,
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: vm.isLoading
                          ? Column(
                              // crossAxisAlignment: CrossA
                              children: [
                                SizedBox(
                                  height: 240,
                                  width: 240,
                                  child: Image.asset(
                                    'assets/logo.png',
                                    colorBlendMode: BlendMode.clear,
                                  ),
                                ),
                                const Text(
                                  '"Believe in something 🌙"',
                                  style: titleStyleDark,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const SpinKitFoldingCube(
                                  color: Colors.black,
                                )
                              ],
                            )
                          : vm.errorMessage != null
                              ? Center(child: Text('Error: ${vm.errorMessage}'))
                              : vm.forIdList.isEmpty
                                  ? const Center(
                                      child: Text('No records found'))
                                  :
                                  // : Responsive.isDesktop(context)
                                  //     ? GridView.builder(
                                  //         gridDelegate:
                                  //             const SliverGridDelegateWithFixedCrossAxisCount(
                                  //           crossAxisCount: 3, // 2 columns
                                  //           crossAxisSpacing:
                                  //               16, // Horizontal spacing between cards
                                  //           mainAxisSpacing:
                                  //               16, // Vertical spacing between cards
                                  //           // childAspectRatio:
                                  //           //     0.75, // Adjust card height/width ratio
                                  //         ),
                                  //         // padding: const EdgeInsets.all(
                                  //         //     16), // Padding around the grid
                                  //         itemCount: vm.forIdList.length,
                                  //         itemBuilder: (context, index) {
                                  //           final forId = vm.forIdList[index];
                                  //           return ForIdCard(
                                  //             forId: forId,
                                  //             vm: vm,
                                  //           );
                                  //         })
                                  //     :
                                  ListView.builder(
                                      itemCount: vm.forIdList.length,
                                      itemBuilder: (context, index) {
                                        final forId = vm.forIdList[index];
                                        return GuestForIdCard(
                                          forId: forId,
                                          vm: vm,
                                        );
                                      },
                                    ),
                    )
                  ],
                ),
              ),
              // vm.isLoading
              //     ? Column(
              //         // crossAxisAlignment: CrossA
              //         children: [
              //           SizedBox(
              //             height: 240,
              //             width: 240,
              //             child: Image.asset(
              //               'assets/logo.png',
              //               colorBlendMode: BlendMode.clear,
              //             ),
              //           ),
              //           const Text(
              //             '"Believe in something 🌙"',
              //             style: titleStyleDark,
              //           ),
              //           const SizedBox(
              //             height: 30,
              //           ),
              //           const SpinKitFoldingCube(
              //             color: Colors.black,
              //           )
              //         ],
              //       )
              //     : vm.errorMessage != null
              //         ? Center(child: Text('Error: ${vm.errorMessage}'))
              //         : vm.forIdList.isEmpty
              //             ? const Center(child: Text('No records found'))
              //             :
              //             // : Responsive.isDesktop(context)
              //             //     ? GridView.builder(
              //             //         gridDelegate:
              //             //             const SliverGridDelegateWithFixedCrossAxisCount(
              //             //           crossAxisCount: 3, // 2 columns
              //             //           crossAxisSpacing:
              //             //               16, // Horizontal spacing between cards
              //             //           mainAxisSpacing:
              //             //               16, // Vertical spacing between cards
              //             //           // childAspectRatio:
              //             //           //     0.75, // Adjust card height/width ratio
              //             //         ),
              //             //         // padding: const EdgeInsets.all(
              //             //         //     16), // Padding around the grid
              //             //         itemCount: vm.forIdList.length,
              //             //         itemBuilder: (context, index) {
              //             //           final forId = vm.forIdList[index];
              //             //           return ForIdCard(
              //             //             forId: forId,
              //             //             vm: vm,
              //             //           );
              //             //         })
              //             //     :
              //             ListView.builder(
              //                 itemCount: vm.forIdList.length,
              //                 itemBuilder: (context, index) {
              //                   final forId = vm.forIdList[index];
              //                   return ForIdCard(
              //                     forId: forId,
              //                     vm: vm,
              //                   );
              //                 },
              //               ),
            ),
          ),
        );
      },
    );
  }
}
