import 'package:flutter/material.dart';
import 'package:personal_safety/models/emergency_contact.dart';
import 'package:personal_safety/widgets/go_back_button.dart';

import '../../theme/colors.dart';

class EditEmergencyContact extends StatelessWidget {
  const EditEmergencyContact({Key? key, this.emergencyContact})
      : super(key: key);

  final EmergencyContact? emergencyContact;

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
            Text(emergencyContact == null
                ? "Add Emergency Contact"
                : "Edit Emergency Contact"),
          ],
        ),
        toolbarHeight: 120,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
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
                                emergencyContact == null
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
                                initialValue: emergencyContact?.name,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Contact Name',
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                initialValue: emergencyContact?.phone,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Contact Phone Number',
                                ),
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
                      Navigator.pop(context);
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
    );
  }
}
