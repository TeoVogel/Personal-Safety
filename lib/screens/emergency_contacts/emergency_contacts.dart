import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:personal_safety/screens/emergency_contacts/edit_emergency_contact.dart';
import 'package:personal_safety/screens/emergency_contacts/emergency_contact_card.dart';
import 'package:personal_safety/widgets/go_back_button.dart';

import '../../models/emergency_contact.dart';

class EmergencyContacts extends StatelessWidget {
  const EmergencyContacts({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  Widget build(BuildContext context) {
    CollectionReference emergencyContacts = FirebaseFirestore.instance
        .collection('users')
        .doc('a30wukbMEsxamPqV0G1w')
        .collection('emergency-contacts');

    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: const [
            Align(alignment: Alignment.centerLeft, child: GoBackButton()),
            SizedBox(height: 16),
            Text("Emergency Contacts"),
          ],
        ),
        toolbarHeight: 120,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: FutureBuilder<QuerySnapshot>(
            future: emergencyContacts.get(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (!snapshot.hasData) {
                return Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    for (var doc in snapshot.data!.docs)
                      EmergencyContactCard(
                          name: doc["name"],
                          number: doc["number"],
                          onEdit: () {}),
                    const Spacer(),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditEmergencyContact(),
                          ),
                        );
                      },
                      label: const Text("ADD CONTACT"),
                      icon: const Icon(Icons.add),
                    ),
                  ],
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
