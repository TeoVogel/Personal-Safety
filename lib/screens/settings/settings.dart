import 'package:flutter/material.dart';
import 'package:personal_safety/theme/themes.dart';

import 'package:personal_safety/widgets/go_back_button.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: const [
            Align(alignment: Alignment.centerLeft, child: GoBackButton()),
            SizedBox(height: 16),
            Text("Settings"),
          ],
        ),
        toolbarHeight: 120,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: <Widget>[
            _buildCardContents(
              "Check-in period",
              "7:00 - 8:00",
              () {
                showTimePicker(
                  context: context,
                  initialTime: const TimeOfDay(hour: 7, minute: 0),
                  initialEntryMode: TimePickerEntryMode.input,
                );
              },
              context,
            ),
            const SizedBox(height: 8),
            _buildCardContents(
              "Buffer period",
              "8:00 - 9:00",
              () {
                showTimePicker(
                  context: context,
                  initialTime: const TimeOfDay(hour: 8, minute: 0),
                  initialEntryMode: TimePickerEntryMode.input,
                );
              },
              context,
            ),
            const SizedBox(height: 8),
            _buildCardContents(
              "Safety prompts frequency",
              "15 min",
              () {},
              context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardContents(title, content, action, context) => Card(
        child: InkWell(
          onTap: action,
          borderRadius: ThemeUtils.mediumShapeBorderRadius,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Text(
                  content,
                  style: Theme.of(context).textTheme.headline3,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "tap to edit",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      const Icon(
                        Icons.edit,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
