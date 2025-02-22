import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:june/june.dart';
import 'package:signature/signature.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_model.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_state.dart';
import 'package:ssnhi_app/data/user/state/auth_state_june.dart';

import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:ssnhi_app/shared/utils/responsive.dart';

class EditForIdMobile extends StatelessWidget {
  final ForIdModel forIdModel;
  const EditForIdMobile({
    super.key,
    required this.forIdModel,
  });

  @override
  Widget build(BuildContext context) {
    final authState = June.getState(() => AuthState());
    return JuneBuilder(() => ForIdState(), builder: (forIdState) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: darkBackground,
          iconTheme: const IconThemeData(color: iconColor),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const FaIcon(Icons.arrow_back_ios_new),
          ),
          title: Text(
            'View ${forIdModel.empName} ❤️‍🔥',
            style: titleStyle,
          ),
          actions: [
            forIdState.canEdit == false
                ? IconButton(
                    onPressed: () {
                      if (authState.user == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'You need an account to edit data. 💀',
                              style: titleStyle,
                            ),
                          ),
                        );
                      } else {
                        forIdState.goEdit();
                      }
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: lightBackground,
                    ))
                :
                // if (forIdState.canEdit == true)
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.save, color: lightBackground)),
            const SizedBox(width: 10),
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: forIdState.forIdformKey,
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
                    enabled: forIdState.canEdit,
                    controller: forIdState.empNameController,
                    keyboardType: TextInputType.name,
                    // initialValue: forIdModel.empName,
                    decoration: InputDecoration(
                      label: const Text('Name'),
                      contentPadding: const EdgeInsets.all(20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                            width: 20, style: BorderStyle.solid),
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
                                enabled: forIdState.canEdit,
                                // initialValue: forIdModel.empNo,
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
                                  hintText: forIdModel.empDept,
                                  onChanged: (value) {
                                    forIdState.empDept = value!;
                                  }),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              width: 300,
                              child: TextFormField(
                                // initialValue: forIdModel.position,
                                enabled: forIdState.canEdit,
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
                        )
                      : Column(
                          children: [
                            TextFormField(
                              controller: forIdState.empNoController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              enabled: forIdState.canEdit,
                              // initialValue: forIdModel.empNo,
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
                            forIdModel.empDept == ""
                                ? SizedBox(
                                    width: 300,
                                    child: CustomDropdown<String>(
                                        items: forIdState.department,
                                        enabled: forIdState.canEdit,
                                        hintText: 'Department',
                                        onChanged: (value) {
                                          forIdState.empDept = value!;
                                        }),
                                  )
                                : SizedBox(
                                    width: 300,
                                    child: CustomDropdown<String>(
                                        enabled: forIdState.canEdit,
                                        items: forIdState.department,
                                        initialItem: forIdModel.empDept,
                                        hintText: 'Department',
                                        onChanged: (value) {
                                          forIdState.empDept = value!;
                                        }),
                                  ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.name,
                              // initialValue: forIdModel.position,
                              enabled: forIdState.canEdit,
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
                    enabled: forIdState.canEdit,
                    // initialValue: forIdState.ecName,
                    decoration: InputDecoration(
                      label: const Text('Name'),
                      prefixIcon: const Icon(Icons.person_2_rounded),
                      contentPadding: const EdgeInsets.all(20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                            width: 10, style: BorderStyle.solid),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: forIdState.ecAddController,
                    enabled: forIdState.canEdit,
                    // initialValue: forIdState.ecAdd,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      label: const Text('Address'),
                      prefixIcon: const Icon(Icons.pin_drop_rounded),
                      contentPadding: const EdgeInsets.all(20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                            width: 10, style: BorderStyle.solid),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: forIdState.ecPhoneController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    enabled: forIdState.canEdit,
                    // initialValue: forIdModel.ecPhone,
                    decoration: InputDecoration(
                      label: const Text('Contact Number'),
                      prefixIcon: const Icon(Icons.phone),
                      contentPadding: const EdgeInsets.all(20),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 10, style: BorderStyle.solid),
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
                  forIdModel.status == ""
                      ? SizedBox(
                          width: 300,
                          child: CustomDropdown<String>(
                              items: forIdState.idStatus,
                              hintText: forIdModel.status,
                              enabled: forIdState.canEdit,
                              onChanged: (value) {
                                forIdState.status = value!;
                              }),
                        )
                      : SizedBox(
                          width: 300,
                          child: CustomDropdown<String>(
                              items: forIdState.idStatus,
                              enabled: forIdState.canEdit,
                              initialItem: forIdModel.status,
                              hintText: forIdModel.status,
                              onChanged: (value) {
                                forIdState.status = value!;
                              }),
                        ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
