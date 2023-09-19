import 'package:flutter/material.dart';
import 'libs/alter_view.dart';
import 'libs/date_time_format.dart';
import 'libs/ui_format.dart';
import 'week_picker.dart';

class WeekPickerButton extends StatefulWidget {
  //初始时间
  final DateTime initialDate;

  //开始时间
  final DateTime firstDate;

  //结束时间
  final DateTime lastDate;

  //回掉函数
  final ValueChanged<DateTime>? onChanged;

  //用于用户自定义按钮上的显示样式，默认 xxxx年 第xx周
  final ButtonTextFormat? buttonTextFormat;

  //用于用户自定义日历的显示样式，默认 第xx周 周一:xx-xx 周日: xx-xx
  final WeekWidgetFormat? weekWidgetFormat;

  final Color? primaryColor;
  final double width;
  final double height;

  const WeekPickerButton({
    Key? key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    this.onChanged,
    this.buttonTextFormat,
    this.weekWidgetFormat,
    this.primaryColor,
    this.width = 350,
    this.height = 450,
  }) : super(key: key);

  @override
  State<WeekPickerButton> createState() => _WeekPickerButtonState();
}

class _WeekPickerButtonState extends State<WeekPickerButton> {
  late String buttonString;

  late DateTime initDate;

  //默认的格式化器
  late WeekWidgetFormat weekWidgetFormat;
  late ButtonTextFormat buttonTextFormat;

  late Color primaryColor;

  bool _innerState = false;

  @override
  void initState() {
    super.initState();
    buttonTextFormat = widget.buttonTextFormat ??
        (int year, int weekNumber) => "$year年 第$weekNumber周";
    weekWidgetFormat = widget.weekWidgetFormat ??
        (int week, DateTime monday, DateTime sunday) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("第$week周"),
                Text(
                  "周一:${DateTimeFormat.toStr(monday, "MM月dd日")}",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  "周日:${DateTimeFormat.toStr(sunday, "MM月dd日")}",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            );
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

  void onChanged(DateTime value) {
    int weekNumber = getWeekNumber(value);
    buttonString = buttonTextFormat(value.year, weekNumber);
    initDate = value;
    _innerState = true;
    setState(() {});
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    if (_innerState) {
      _innerState = false;
    } else {
      initDate = widget.initialDate;
    }
    buttonString = buttonTextFormat(initDate.year, getWeekNumber(initDate));
    primaryColor = widget.primaryColor ?? Theme.of(context).primaryColor;
    return TextButton(
      onPressed: () {
        AlertView(
          context: context,
          content: WeekPicker(
            initialDate: initDate,
            firstDate: widget.firstDate,
            lastDate: widget.lastDate,
            weekWidgetFormat: weekWidgetFormat,
            onChanged: onChanged,
            primaryColor: primaryColor,
            width: widget.width,
            height: widget.width,
          ),
        ).show();
      },
      child: Text(buttonString),
    );
  }
}
