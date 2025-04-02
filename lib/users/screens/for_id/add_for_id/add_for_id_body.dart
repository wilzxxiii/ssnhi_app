import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:june/june.dart';
import 'package:signature/signature.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_state.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

// final ForIdFormVM vm;

// const AddForIdMobileBody({super.key, required this.vm});

class AddForIdBody extends StatelessWidget {
  final ForIdState vm;
  const AddForIdBody({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    // StatusSelection? statusSelection = StatusSelection.collecting;

    final forIdState = June.getState(() => ForIdState());
    return SingleChildScrollView(
      child: Container(
        color: scaffoldColor,
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Text('Employee Details',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: textBoxHeight,
                      child: TextFormField(
                        controller: forIdState.empNameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          label: const Text('Name'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                width: 20, style: BorderStyle.solid),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: textBoxHeight,
                      child: TextFormField(
                        controller: forIdState.empNoController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        validator: MinLengthValidator(0,
                                errorText: 'Shouldn\'t be empty.')
                            .call,
                        decoration: InputDecoration(
                          label: const Text('Employee Number'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                width: 20, style: BorderStyle.solid),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 200,
                      height: textBoxHeight + 15,
                      decoration: BoxDecoration(
                          border: Border.all(
                              style: BorderStyle.solid, color: Colors.black)),
                      child: CustomDropdown<String>(
                          items: forIdState.department,
                          hintText: 'Department',
                          onChanged: (value) {
                            vm.empDept = value!;
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: textBoxHeight,
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        controller: forIdState.empPositionController,
                        validator: MinLengthValidator(0,
                                errorText: 'Shouldn\'t be empty.')
                            .call,
                        decoration: InputDecoration(
                          label: const Text('Position'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                width: 20, style: BorderStyle.solid),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Text('Emergency Contact Person Details',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: textBoxHeight,
                      child: TextFormField(
                        controller: forIdState.ecNameController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          label: const Text('Name'),
                          prefixIcon: const Icon(Icons.person_2_rounded),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                width: 10, style: BorderStyle.solid),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: textBoxHeight,
                      child: TextFormField(
                        controller: forIdState.ecAddController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                          label: const Text('Address'),
                          prefixIcon: const Icon(Icons.pin_drop_rounded),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                width: 10, style: BorderStyle.solid),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: textBoxHeight,
                      child: TextFormField(
                        controller: forIdState.ecPhoneController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          label: const Text('Contact Number'),
                          prefixIcon: const Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 10, style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '⬇️ Signature ⬇️',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Signature(
                key: const Key('signature'),
                controller: forIdState.sigController,
                height: 300,
                backgroundColor: Colors.blue[200]!,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    forIdState.sigController.clear();
                  },
                  child: const Text('Clear Signature'),
                ),
                const SizedBox(width: 20),
                OutlinedButton(
                  onPressed: () {
                    forIdState.sigController.undo();
                  },
                  child: const Text('Undo'),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text('ID Status',
                    style: TextStyle(
                      fontSize: 22,
                    )),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 200,
                  height: textBoxHeight + 15,
                  child: CustomDropdown<String>(
                      items: forIdState.idStatus,
                      hintText: 'Status',
                      onChanged: (value) {
                        vm.status = value!;
                      }),
                ),
              ],
            ),

            // ListTile(
            //   title: const Text('Collecting data'),
            //   leading: Radio<StatusSelection>(
            //     value: StatusSelection.collecting,
            //     groupValue: statusSelection,
            //     onChanged: (StatusSelection? value) {
            //       // setState(() {
            //       //   _character = value;
            //       // });
            //       statusSelection = value;
            //       print(statusSelection.toString());
            //     },
            //   ),
            // ),
            // ListTile(
            //   title: const Text('Working on it'),
            //   leading: Radio<StatusSelection>(
            //     value: StatusSelection.collecting,
            //     groupValue: statusSelection,
            //     onChanged: (StatusSelection? value) {
            //       // setState(() {
            //       statusSelection = value;
            //       print(statusSelection.toString());
            //       // });
            //     },
            //   ),
            // ),
            // ListTile(
            //   title: const Text('Done'),
            //   leading: Radio<StatusSelection>(
            //     value: StatusSelection.collecting,
            //     groupValue: statusSelection,
            //     onChanged: (StatusSelection? value) {
            //       // setState(() {
            //       //   _character = value;
            //       statusSelection = value;
            //       print(statusSelection.toString());
            //       // });
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
