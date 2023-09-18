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

  String buttonString = "";

  DateTime? initDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initDate = widget.initialDate;

    buttonString =
        "${DateTimeFormat.toStr(initDate!, "yyyy")}年 第${getWeekNumber(initDate!)}周";

    setState(() {});
  }

  int getWeekNumber(DateTime date) {
    int dayOfYear = int.parse(DateTimeFormat.toStr(date, "D"));
    int woy = ((dayOfYear - date.weekday + 10) / 7).floor();
    if (woy < 1) {
      woy = numOfWeeks(date.year - 1);
    } else if (woy > numOfWeeks(date.year)) {
      woy = 1;
    }
    return woy;
  }

  //一年一共有几周
  int numOfWeeks(int year) {
    DateTime dec28 = DateTime(year, 12, 28);
    int dayOfDec28 = int.parse(DateTimeFormat.toStr(dec28, "D"));
    return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
  }

  @override
  Widget build(BuildContext context) {
    return TextButtonExt(
      title: buttonString,
      onPressed: () {
        AlertView(
          context: context,
          content: WeekPicker(
            initialDate: initDate!,
            firstDate: widget.firstDate,
            lastDate: widget.lastDate,
            onChanged: (value) {
              DateTime time = DateTimeFormat.toDateTime(value);
              buttonString =
                  "${DateTimeFormat.toStr(time, "yyyy")}年 第${getWeekNumber(time)}周";
              initDate = DateTimeFormat.toDateTime(value);
              setState(() {});
              widget.onChanged.call(value);
            },
          ),
        ).show();
      },
    );
  }
}
