import 'package:flutter/material.dart';
import 'package:personal_safety/theme/themes.dart';
import 'package:personal_safety/utils/checkin_time_preferences.dart';
import 'package:personal_safety/utils/notification_service.dart';

import 'package:personal_safety/widgets/go_back_button.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TimeOfDay? checkInTime;
  String? checkInTimeLabel;
  String? bufferTimeLabel;

  @override
  void initState() {
    super.initState();
    fetchCheckInTimePreferences();
  }

  void fetchCheckInTimePreferences() async {
    final TimeOfDay timePref = await getCheckInTime();
    setState(() {
      checkInTime = timePref;
      final minutesLabel = timePref.minute == 0
          ? "00"
          : timePref.minute < 10
              ? "0${timePref.minute}"
              : "${timePref.minute}";
      checkInTimeLabel =
          "${timePref.hour}:$minutesLabel - ${timePref.hour + 1}:$minutesLabel";
      bufferTimeLabel =
          "${timePref.hour + 1}:$minutesLabel - ${timePref.hour + 2}:$minutesLabel";
    });
  }

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
              checkInTimeLabel,
              () {
                if (checkInTime == null) return;
                Future<TimeOfDay?> selectedTime = showTimePicker(
                  context: context,
                  initialTime: checkInTime!,
                  initialEntryMode: TimePickerEntryMode.input,
                  builder: (BuildContext context, Widget? child) {
                    return MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(alwaysUse24HourFormat: true),
                      child: child!,
                    );
                  },
                );
                selectedTime.then((value) async {
                  if (value == null) return;
                  setCheckInTime(value);
                  fetchCheckInTimePreferences();
                  NotificationService().programNotification(value);
                });
              },
              context,
            ),
            const SizedBox(height: 8),
            _buildCardContents(
              "Buffer period",
              bufferTimeLabel,
              () {},
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

  Widget _buildCardContents(title, String? content, action, context) => Card(
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
                  content ?? "",
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
