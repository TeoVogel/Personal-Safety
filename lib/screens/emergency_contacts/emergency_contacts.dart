import 'package:flutter/material.dart';

class EmergencyContacts extends StatelessWidget {
  const EmergencyContacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency Contacts"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            for (var i = 0; i < 3; i++)
              Card(
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
                                "Susan",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "+1 123 456789",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: OutlinedButton(
                                  onPressed: () {},
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
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {},
              label: const Text("ADD CONTACT"),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
