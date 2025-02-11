import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:signature/signature.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_state.dart';

import 'package:ssnhi_app/shared/utils/responsive.dart';

// final ForIdFormVM vm;

// const AddForIdMobileBody({super.key, required this.vm});

class AddForIdMobileBody extends StatelessWidget {
  final ForIdFormVM vm;
  const AddForIdMobileBody({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: vm.formKey,
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
                controller: vm.empNameController,
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
              Responsive.isDesktop(context)
                  ? Row(
                      children: [
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            controller: vm.empNoController,
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
                          child: TextFormField(
                            controller: vm.empDepartmentController,
                            validator: MinLengthValidator(0,
                                    errorText: 'Shouldn\'t be empty.')
                                .call,
                            decoration: InputDecoration(
                              label: const Text('Department'),
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
                          child: TextFormField(
                            controller: vm.empPositionController,
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
                    )
                  : Column(
                      children: [
                        TextFormField(
                          controller: vm.empNoController,
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
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: vm.empDepartmentController,
                          validator: MinLengthValidator(0,
                                  errorText: 'Shouldn\'t be empty.')
                              .call,
                          decoration: InputDecoration(
                            label: const Text('Department'),
                            contentPadding: const EdgeInsets.all(20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(
                                  width: 20, style: BorderStyle.solid),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: vm.empPositionController,
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
                      ],
                    ),
              const SizedBox(height: 20),
              const Text('Emergency Contact Person Details',
                  style: TextStyle(
                    fontSize: 22,
                  )),
              TextFormField(
                controller: vm.ecNameController,
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
                controller: vm.ecAddController,
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
                controller: vm.ecPhoneController,
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
                width: Responsive.isDesktop(context)
                    ? MediaQuery.of(context).size.width * 0.3
                    : MediaQuery.of(context).size.width,
                child: Signature(
                  key: const Key('signature'),
                  controller: vm.sigController,
                  height: 300,
                  backgroundColor: Colors.blue[200]!,
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                  onPressed: () {
                    vm.sigController.clear();
                  },
                  child: const Text('Clear Signature'))
            ],
          ),
        ),
      ),
    );
  }
}
