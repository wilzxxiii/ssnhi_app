import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:june/june.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_state.dart';

import 'package:ssnhi_app/users/screens/for_id/add_for_id/add_for_id.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:ssnhi_app/users/screens/for_id/for_id_card.dart';

class ForId extends StatelessWidget {
  const ForId({super.key});

  @override
  Widget build(BuildContext context) {
    // final webState = June.getState(() => DashboardState());
    return JuneBuilder(
      () => ForIdState(),
      builder: (vm) {
        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              //web
              // showDialog(
              //     barrierDismissible: false,
              //     context: context,
              //     builder: (context) => Padding(
              //           padding: const EdgeInsets.all(40.0),
              //           child: AddForId(vm: vm),
              //         ));

//mobile
              showCupertinoModalBottomSheet(
                  context: context, builder: (context) => AddForId(vm: vm));
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
            iconTheme: const IconThemeData(color: iconColor),
            leading: IconButton(
              onPressed: () {
                vm.clearForIdModel();
                vm.clearControllers();

                // webState.showMoonDashboard();
                Navigator.pop(context);
              },
              icon: const FaIcon(Icons.close_rounded),
            ),
            title: const Text(
              'For ID\'s 💫',
              style: titleStyle,
            ),
            toolbarHeight: appBarHeight,
            backgroundColor: darkBackground,
          ),
          body: vm.isLoading
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
                      ? const Center(child: Text('No records found'))
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
                            return ForIdCard(
                              forId: forId,
                              vm: vm,
                            );
                          },
                        ),
        );
      },
    );
  }
}
