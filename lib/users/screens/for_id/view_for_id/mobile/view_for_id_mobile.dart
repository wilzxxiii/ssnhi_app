import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:june/june.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_model.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_state.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';
import 'package:ssnhi_app/users/screens/for_id/edit_for_id/edit_for_id.dart';

class ViewForIdMobile extends StatelessWidget {
  final ForIdModel forIdModel;
  const ViewForIdMobile({
    super.key,
    required this.forIdModel,
  });

  @override
  Widget build(BuildContext context) {
    final forIdState = June.getState(() => ForIdState());
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => EditForId(forIdModel: forIdModel)));
          },
          label: const Text(
            'Edit 🖊️',
            style: titleStyle,
          ),
          backgroundColor: darkBackground,
          hoverColor: hoverColor,
        ),
        appBar: AppBar(
          toolbarHeight: 80,
          centerTitle: true,
          backgroundColor: darkBackground,
          iconTheme: const IconThemeData(color: iconColor),
          leading: IconButton(
            onPressed: () {
              forIdState.clearForIdModel();
              forIdState.clearControllers();
              Navigator.pop(context);
            },
            icon: const FaIcon(Icons.arrow_back_ios_new),
          ),
          title: const Text(
            'Viewing 👀',
            style: titleStyle,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    '📇 Employee Details 📇',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Employee Name:', style: titleStyleDark),
                const SizedBox(height: 8),
                SelectableText(
                    forIdModel.empName.isEmpty ? 'None' : forIdModel.empName,
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Employee Number:', style: titleStyleDark),
                const SizedBox(height: 8),
                SelectableText(
                    forIdModel.empNo.isEmpty ? 'None' : forIdModel.empNo,
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Employee Department:', style: titleStyleDark),
                const SizedBox(height: 8),
                SelectableText(
                    forIdModel.empDept.isEmpty ? 'None' : forIdModel.empDept,
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Signature:', style: titleStyleDark),
                const SizedBox(height: 8),
                forIdModel.signature.isEmpty
                    ? Text('No signature added',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.blue[900],
                            fontWeight: FontWeight.bold))
                    : Center(
                        child:
                            forIdState.signatureToImage(forIdModel.signature)),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    '🆘 Emergency Contact Details 🆘',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Emergency Contact Person:', style: titleStyleDark),
                const SizedBox(height: 8),
                SelectableText(
                    forIdModel.ecName.isEmpty ? 'None' : forIdModel.ecName,
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Emergency Contact Phone Number:',
                    style: titleStyleDark),
                const SizedBox(height: 8),
                SelectableText(
                    forIdModel.ecPhone.isEmpty ? 'None' : forIdModel.ecPhone,
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Emergency Contact Address:', style: titleStyleDark),
                const SizedBox(height: 8),
                SelectableText(
                    forIdModel.ecAdd.isEmpty ? 'None' : forIdModel.ecAdd,
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ));
  }
}
