import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_model.dart';
import 'package:ssnhi_app/data/entity/for_id/for_id_state.dart';
import 'package:ssnhi_app/users/screens/for_id/add%20for%20id/add_for_id.dart';
import 'package:ssnhi_app/shared/constants/constants.dart';

class ForIdMobile extends StatelessWidget {
  const ForIdMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddForID()));
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
            Navigator.pop(context);
          },
          icon: const FaIcon(Icons.arrow_back_ios_new),
        ),
        title: const Text(
          'List of For ID\'s 💫',
          style: titleStyle,
        ),
        toolbarHeight: 80,
        elevation: 10,
        backgroundColor: mainColor,
      ),
      body: StreamBuilder<List<ForIdModel>>(
        stream:
            ForIdState().forIdState(), // Assuming this method returns a Stream
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No records found.'));
          }

          final forIdList = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: forIdList.length,
            itemBuilder: (context, index) {
              final forId = forIdList[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text(
                    forId.empName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text('Employee No: ${forId.empNo}'),
                      Text('Department: ${forId.empDept}'),
                      Text('Position: ${forId.position}'),
                      const SizedBox(height: 8),
                      Text('Emergency Contact: ${forId.ecName}'),
                      Text('Contact Address: ${forId.ecAdd}'),
                      Text('Contact Phone: ${forId.ecPhone}'),
                      const SizedBox(height: 4),
                      Text('Status: ${forId.status}'),
                    ],
                  ),
                  onTap: () {
                    // Navigate to a detail screen or edit screen
                    // Example:
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => EditForIDScreen(forId: forId),
                    //   ),
                    // );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
