import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/emergency_contact.dart';
import 'edit_emergency_contact.dart';

class EmergencyContactCard extends StatelessWidget {
  const EmergencyContactCard({
    Key? key,
    required this.emergencyContactsReference,
    required this.name,
    required this.number,
    required this.id,
    required this.onEdit,
  }) : super(key: key);

  final CollectionReference emergencyContactsReference;
  final String name;
  final int number;
  final String id;
  final Function() onEdit;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(
              Icons.person_outline,
              size: 48,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      name,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${number}",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                        onPressed: onEdit,
                        child: const Text("EDIT"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
