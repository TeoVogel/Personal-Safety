import 'package:flutter/material.dart';
import 'package:personal_safety/theme/themes.dart';

class GoBackButton extends StatelessWidget {
  const GoBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: getGoBackButtonStyle(),
      label: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text("GO BACK"),
      ),
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
