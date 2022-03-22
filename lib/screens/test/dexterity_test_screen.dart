import 'package:flutter/material.dart';
import 'package:personal_safety/screens/test/dexterity_test_widget.dart';

class DexterityTestScreen extends StatelessWidget {
  const DexterityTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: DexterityTestWidget(),
      ),
    );
  }
}
