import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:june/june.dart';
import 'package:signature/signature.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_state.dart';

// final ForIdFormVM vm;

// const AddForIdMobileBody({super.key, required this.vm});

class AddForIdWebBody extends StatelessWidget {
  final ForIdState vm;
  const AddForIdWebBody({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    // StatusSelection? statusSelection = StatusSelection.collecting;

    final forIdState = June.getState(() => ForIdState());
    return SingleChildScrollView(
      child: Form(
        key: vm.forIdformKey,
        child: Container(
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Employee Details',
                  style: TextStyle(
                    fontSize: 22,
                  )),
              const SizedBox(height: 20),
              TextFormField(
                controller: forIdState.empNameController,
                keyboardType: TextInputType.name,
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
              Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      controller: forIdState.empNoController,
                      validator: MinLengthValidator(0,
                              errorText: 'Shouldn\'t be empty.')
                          .call,
                      decoration: InputDecoration(
                        label: const Text('Employee Number'),
                        contentPadding: const EdgeInsets.all(20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                              width: 20, style: BorderStyle.solid),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: CustomDropdown<String>(
                        items: forIdState.department,
                        hintText: 'Department',
                        onChanged: (value) {
                          vm.empDept = value!;
                        }),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      controller: forIdState.empPositionController,
                      validator: MinLengthValidator(0,
                              errorText: 'Shouldn\'t be empty.')
                          .call,
                      decoration: InputDecoration(
                        label: const Text('Position'),
                        contentPadding: const EdgeInsets.all(20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                              width: 20, style: BorderStyle.solid),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              const Text('Emergency Contact Person Details',
                  style: TextStyle(
                    fontSize: 22,
                  )),
              TextFormField(
                controller: forIdState.ecNameController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  label: const Text('Name'),
                  prefixIcon: const Icon(Icons.person_2_rounded),
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
                controller: forIdState.ecAddController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                  label: const Text('Address'),
                  prefixIcon: const Icon(Icons.pin_drop_rounded),
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
                controller: forIdState.ecPhoneController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  label: const Text('Contact Number'),
                  prefixIcon: const Icon(Icons.phone),
                  contentPadding: const EdgeInsets.all(20),
                  border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 10, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
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
              SizedBox(
                width: 300,
                child: CustomDropdown<String>(
                    items: forIdState.idStatus,
                    hintText: 'Status',
                    onChanged: (value) {
                      vm.status = value!;
                    }),
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
      ),
    );
  }
}
