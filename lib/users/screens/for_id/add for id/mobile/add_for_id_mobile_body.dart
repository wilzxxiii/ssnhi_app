import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:signature/signature.dart';
import 'package:ssnhi_app/shared/utils/responsive.dart';

class AddForIdMobileBody extends StatefulWidget {
  const AddForIdMobileBody({
    super.key,
  });

  @override
  State<AddForIdMobileBody> createState() => _AddForIdMobileBodyState();
}

class _AddForIdMobileBodyState extends State<AddForIdMobileBody> {
  //

  // initialize the signature controller
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
    exportPenColor: Colors.black,
    onDrawStart: () => log('onDrawStart called!'),
    onDrawEnd: () => log('onDrawEnd called!'),
  );

  // @override
  // void initState() {
  //   super.initState();
  //   _controller
  //     ..addListener(() => log('Value changed'))
  //     ..onDrawEnd = () => setState(
  //           () {
  //             // setState for build to update value of "empty label" in gui
  //           },
  //         );
  // }

  @override
  void dispose() {
    // IMPORTANT to dispose of the controller
    _controller.dispose();
    super.dispose();
  }

  String dropdownvalue = 'Nursing';

  var dept = [
    'Nursing',
    'Ancilliary',
    'Admin',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            Responsive.isDesktop(context)
                ? Row(
                    children: [
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          validator: MinLengthValidator(0,
                                  errorText: 'Shouldn\'t be empty.')
                              .call,
                          onChanged: (val) {},
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
                      const Text('Department',
                          style: TextStyle(
                            fontSize: 22,
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      DropdownButton(
                        value: dropdownvalue,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: dept.map((String dept) {
                          return DropdownMenuItem(
                            value: dept,
                            child: Text(dept),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      ),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          validator: MinLengthValidator(0,
                                  errorText: 'Shouldn\'t be empty.')
                              .call,
                          onChanged: (val) {},
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
                      Row(
                        children: [
                          const Text('Department',
                              style: TextStyle(
                                fontSize: 22,
                              )),
                          const SizedBox(
                            width: 20,
                          ),
                          DropdownButton(
                            value: dropdownvalue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: dept.map((String dept) {
                              return DropdownMenuItem(
                                value: dept,
                                child: Text(dept),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(height: 20),
            TextFormField(
              onChanged: (val) {},
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
            const Text('Emergency Contact Person Details',
                style: TextStyle(
                  fontSize: 22,
                )),
            TextFormField(
              onChanged: (val) {},
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
              // controller: confirmPasswordCtrl,

              // onChanged: (val) {},

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
                controller: _controller,
                height: 300,
                backgroundColor: Colors.blue[200]!,
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
                onPressed: () {
                  setState(() {
                    _controller.clear();
                  });
                },
                child: const Text('Clear Signature'))
          ],
        ),
      ),
    );
  }
}
