import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:personal_safety/theme/colors.dart';
import 'package:personal_safety/theme/themes.dart';

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
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              decoration: ShapeDecoration(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                        ThemeUtils.mediumShapeBorderRadiusAmount),
                    bottomLeft: Radius.circular(
                        ThemeUtils.mediumShapeBorderRadiusAmount),
                  ),
                ),
                color: colorPrimary20,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.person_outline,
                  size: 48,
                  color: colorPrimary80,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        name,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          const Icon(Icons.phone),
                          const SizedBox(width: 5),
                          Text(
                            "${number}",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
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
      ),
    );
  }
}
