import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:personal_safety/models/emergency_contact.dart';
import 'package:personal_safety/widgets/go_back_button.dart';

import '../../theme/colors.dart';

class EditEmergencyContact extends StatefulWidget {
  const EditEmergencyContact(
      {Key? key,
      required this.emergencyContactsReference,
      this.emergencyContact})
      : super(key: key);

  final CollectionReference emergencyContactsReference;
  final EmergencyContact? emergencyContact;

  @override
  State<EditEmergencyContact> createState() => _EditEmergencyContactState();
}

class _EditEmergencyContactState extends State<EditEmergencyContact> {
  final nameController = TextEditingController();
  final numberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.emergencyContact?.name ?? "";
    numberController.text = widget.emergencyContact?.phone.toString() ?? "";
  }

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Align(alignment: Alignment.centerLeft, child: GoBackButton()),
            const SizedBox(height: 16),
            Text(widget.emergencyContact == null
                ? "Add Emergency Contact"
                : "Edit Emergency Contact"),
          ],
        ),
        toolbarHeight: 120,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    ListView(
                      shrinkWrap: true,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.person_outline,
                                    size: 100,
                                    color: colorPrimary.withAlpha(125),
                                  ),
                                ),
                                Icon(
                                  widget.emergencyContact == null
                                      ? Icons.add
                                      : Icons.edit,
                                  size: 32,
                                  color: colorPrimary.withAlpha(125),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Contact Name',
                                  ),
                                  controller: nameController,
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Contact Phone Number',
                                  ),
                                  controller: numberController,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _saveEmergencyContact(
                          nameController.text,
                          int.parse(numberController.text),
                          widget.emergencyContact?.id,
                        ).then(
                          (value) => Navigator.pop(context),
                        );
                      },
                      label: const Text("SAVE"),
                      icon: const Icon(Icons.save_outlined),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveEmergencyContact(String name, int number, String? id) {
    if (id == null) {
      return widget.emergencyContactsReference
          .add({
            'name': name,
            'number': number,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    } else {
      return widget.emergencyContactsReference
          .doc(id)
          .update({
            "name": name,
            "number": number,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
  }
}
