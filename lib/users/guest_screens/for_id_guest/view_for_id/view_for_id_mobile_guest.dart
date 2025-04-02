import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:june/june.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_model.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_state.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

class ViewForIdGuest extends StatelessWidget {
  final ForIdModel forIdModel;
  const ViewForIdGuest({
    super.key,
    required this.forIdModel,
  });

  @override
  Widget build(BuildContext context) {
    final forIdState = June.getState(() => ForIdState());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: appBarHeight,
        centerTitle: true,
        backgroundColor: darkBackground,
        iconTheme: const IconThemeData(color: iconColor),
        leading: IconButton(
          onPressed: () {
            forIdState.clearForIdModel();
            forIdState.clearControllers();

            Navigator.pop(context);
          },
          icon: const FaIcon(Icons.close_rounded),
        ),
        title: forIdModel.empName.isEmpty
            ? const Text(
                'Whoops! Seems like you forgot to enter a name',
                style: titleStyle,
              )
            : Text(
                '${forIdModel.empName} 👀',
                style: titleStyle,
              ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Card(
                elevation: 4,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          '💖 Employee Details 💖',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Employee Name:',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      const SizedBox(height: 8),
                      SelectableText(
                          forIdModel.empName.isEmpty
                              ? 'None'
                              : forIdModel.empName,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      const Text('Employee Number:',
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                      const SizedBox(height: 8),
                      SelectableText(
                          forIdModel.empNo.isEmpty ? 'None' : forIdModel.empNo,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      const Text('Employee Department:',
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                      const SizedBox(height: 8),
                      SelectableText(
                          forIdModel.empDept.isEmpty
                              ? 'None'
                              : forIdModel.empDept,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      const Text('Position:',
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                      const SizedBox(height: 8),
                      SelectableText(
                          forIdModel.position.isEmpty
                              ? 'None'
                              : forIdModel.position,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      const Text('Signature:',
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                      const SizedBox(height: 8),
                      forIdModel.signature.isEmpty
                          ? Text('No signature added',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.bold))
                          : Center(
                              child: forIdState
                                  .signatureToImage(forIdModel.signature)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          '📞 Emergency Contact Details 🆘',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('Emergency Contact Person:',
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                      const SizedBox(height: 8),
                      SelectableText(
                          forIdModel.ecName.isEmpty
                              ? 'None'
                              : forIdModel.ecName,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      const Text('Emergency Contact Phone Number:',
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                      const SizedBox(height: 8),
                      SelectableText(
                          forIdModel.ecPhone.isEmpty
                              ? 'None'
                              : forIdModel.ecPhone,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      const Text('Emergency Contact Address:',
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                      const SizedBox(height: 8),
                      SelectableText(
                          forIdModel.ecAdd.isEmpty ? 'None' : forIdModel.ecAdd,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
