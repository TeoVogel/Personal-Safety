import 'package:flutter/material.dart';
import 'package:personal_safety/theme/colors.dart';
import 'package:personal_safety/theme/themes.dart';
import 'package:personal_safety/utils/checkin_time_preferences.dart';
import 'package:personal_safety/utils/notification_service.dart';

import 'package:personal_safety/widgets/go_back_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TimeOfDay? checkInTime;
  String? checkInTimeLabel;
  String? bufferTimeLabel;

  @override
  void initState() {
    super.initState();
    fetchCheckInTimePreferences();
  }

  void fetchCheckInTimePreferences() async {
    final TimeOfDay checkInTimePref = await getCheckInTime();
    final TimeOfDay bufferWindowTimePref = await getBufferWindowTime();
    final TimeOfDay emergencyWindowTimePref = await getEmergencyWindowTime();
    setState(() {
      checkInTime = checkInTimePref;
      final minutesLabel = checkInTimePref.minute == 0
          ? "00"
          : checkInTimePref.minute < 10
              ? "0${checkInTimePref.minute}"
              : "${checkInTimePref.minute}";
      checkInTimeLabel =
          "${checkInTimePref.hour}:$minutesLabel - ${bufferWindowTimePref.hour}:$minutesLabel";
      bufferTimeLabel =
          "${bufferWindowTimePref.hour}:$minutesLabel - ${emergencyWindowTimePref.hour}:$minutesLabel";
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
                selectedTime.then(
                  (value) async {
                    if (value == null) return;
                    setCheckInTime(value).then((success) {
                      if (success) {
                        fetchCheckInTimePreferences();
                        final notificationService = NotificationService();
                        notificationService.programCheckInNotification();
                        notificationService.programDexterityTestNotifications();
                      }
                    });
                  },
                );
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: ShapeDecoration(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          ThemeUtils.mediumShapeBorderRadiusAmount),
                      topRight: Radius.circular(
                          ThemeUtils.mediumShapeBorderRadiusAmount),
                    ),
                  ),
                  color: colorPrimary20,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  content ?? "",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8, bottom: 8),
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
      );
}
