import 'package:flutter/material.dart';
import 'package:personal_safety/utils/checkin_helper.dart';

class DexterityTestWidget extends StatefulWidget {
  const DexterityTestWidget({Key? key}) : super(key: key);

  @override
  State<DexterityTestWidget> createState() => _DexterityTestWidgetState();
}

class _DexterityTestWidgetState extends State<DexterityTestWidget> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "You have missed your check-in time.",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  "We want to make sure you are safe!",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Type the word \"YES\" to proceed with the check-in:",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: myController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    if (myController.text.toUpperCase() == "YES") {
                      checkIn();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('You failed the test. Try again.'),
                      ));
                    }
                  },
                  label: const Text("NEXT"),
                  icon: const Icon(Icons.check),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
}
