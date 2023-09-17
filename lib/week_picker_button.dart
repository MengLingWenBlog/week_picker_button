import 'package:flutter/material.dart';
import 'kit/alter/alter_view.dart';
import 'kit/date_time_format.dart';
import 'kit/text_button_ext.dart';
import 'week_picker.dart';

class WeekPickerButton extends StatefulWidget {
  final DateTime initialDate;
  final String firstDate;
  final String lastDate;
  final ValueChanged<String> onChanged;

  const WeekPickerButton({
    Key? key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<WeekPickerButton> createState() => _WeekPickerButtonState();
}

class _WeekPickerButtonState extends State<WeekPickerButton> {
  // DateTime? initialDate;

  String date = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    date =
        "${DateTimeFormat.toStr(widget.initialDate, "yyyy")}年 第${getWeekNumber(widget.initialDate)}周";
    setState(() {});
  }

  int getWeekNumber(DateTime date) {
    DateTime januaryFirst = DateTime(date.year, 1, 1);
    int daysOffset = januaryFirst.weekday - 1;
    DateTime firstMonday = januaryFirst.subtract(Duration(days: daysOffset));
    int currentDayOfYear = date.difference(firstMonday).inDays + 1;
    int currentWeek = (currentDayOfYear / 7).ceil();
    return currentWeek;
  }

  @override
  Widget build(BuildContext context) {
    return TextButtonExt(
      title: date,
      onPressed: () {
        AlertView(
          context: context,
          content: WeekPicker(
            initialDate: widget.initialDate,
            firstDate: widget.firstDate,
            lastDate: widget.lastDate,
            onChanged: (value) {
              DateTime time = DateTimeFormat.toDateTime(value);
              date =
                  "${DateTimeFormat.toStr(time, "yyyy")}年 第${getWeekNumber(time)}周";
              setState(() {});
              widget.onChanged.call(value);
            },
          ),
        ).show();
      },
    );
  }
}
