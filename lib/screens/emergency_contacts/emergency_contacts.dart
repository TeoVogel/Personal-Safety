import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:personal_safety/screens/emergency_contacts/edit_emergency_contact.dart';
import 'package:personal_safety/screens/emergency_contacts/emergency_contact_card.dart';
import 'package:personal_safety/widgets/go_back_button.dart';

import '../../models/emergency_contact.dart';

class EmergencyContacts extends StatefulWidget {
  const EmergencyContacts({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  State<EmergencyContacts> createState() => _EmergencyContactsState();
}

class _EmergencyContactsState extends State<EmergencyContacts> {
  @override
  Widget build(BuildContext context) {
    CollectionReference emergencyContacts = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
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
                        emergencyContactsReference: emergencyContacts,
                        name: doc["name"],
                        number: doc["number"],
                        id: doc.id,
                        onEdit: () {
                          goToEditEmergencyContact(
                            emergencyContacts,
                            EmergencyContact(
                              doc["name"],
                              "${doc["number"]}",
                              doc.id,
                            ),
                          );
                        },
                      ),
                    const Spacer(),
                    ElevatedButton.icon(
                      onPressed: () {
                        goToEditEmergencyContact(emergencyContacts, null);
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

  void goToEditEmergencyContact(CollectionReference emergencyContacts,
      EmergencyContact? emergencyContact) {
    Future.delayed(Duration.zero, () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditEmergencyContact(
            emergencyContactsReference: emergencyContacts,
            emergencyContact: emergencyContact,
          ),
        ),
      ).then(
        (value) {
          setState(() {});
        },
      );
    });
  }
}
