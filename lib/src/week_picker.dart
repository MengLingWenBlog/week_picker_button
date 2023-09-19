import 'package:flutter/material.dart';
import 'libs/date_time_format.dart';
import 'libs/drop_button.dart';

import 'libs/ui_format.dart';

class WeekPicker extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime>? onChanged;
  final WeekWidgetFormat weekWidgetFormat;
  final Color primaryColor;
  final double width;
  final double height;

  const WeekPicker({
    Key? key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.weekWidgetFormat,
    required this.primaryColor,
    this.onChanged,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  State<WeekPicker> createState() => _WeekPickerState();
}

class _WeekPickerState extends State<WeekPicker> {
  List<WeekItem> weekList = []; //GridView的数据源
  DateTime now = DateTime.now();

  int selectWeekNumber = 0; //选中的是第几周

  int nowWeekNumber = 0; //当前时间是第几周

  late int nowDate; //初始是当前年份,之后是选择的年份

  late DateTime startDate; //开始时间

  late DateTime endDate; //结束时间

  List<int> yearList = []; //年份列表

  @override
  void initState() {
    super.initState();

    nowDate = widget.initialDate.year; // 初始化当前年份

    nowWeekNumber = getWeekNumber(widget.initialDate); //初始化当前是第几周

    List<DateTime> weekToDay = weekToDayFormat(nowDate, nowWeekNumber);

    startDate = weekToDay[0]; //初始化开始时间

    endDate = weekToDay[1]; //初始化结束时间

    getYearList(); //

    _getData(); //获取数据
  }

  //获取初始化年份数据
  void getYearList() {
    int firstYear = widget.firstDate.year;
    int lastYear = widget.lastDate.year + 1;
    yearList = List.generate(lastYear - firstYear, (index) => firstYear + index)
        .toList();
  }

  //年份改变
  void onChangeYear(value) {
    nowDate = value;
    _getData();
  }

  //返回当前时间是第几周
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

  //加载数据
  void _getData() {
    int weekNumber = numOfWeeks(nowDate); //选中的时间有多少个周
    weekList.clear();

    for (int i = 1; i < weekNumber + 1; i++) {
      List<DateTime> list = weekToDayFormat(nowDate, i); //每个周的开始时间和结束时间
      weekList.add(
        WeekItem(
          weekNumber: i,
          start: list[0],
          end: list[1],
          selected: nowWeekNumber == i ? true : false,
          color: list[0].isBefore(widget.firstDate) ||
                  list[0].isAfter(widget.lastDate)
              ? Colors.grey.shade200
              : Colors.white,
        ),
      );
    }
    setState(() {});
  }

  //取消
  void onTapWeek() {
    Navigator.pop(context);
  }

  //确定
  void onEnterWeekPicker() {
    widget.onChanged?.call(startDate);
    Navigator.pop(context);
  }

  //选择
  void selectWeeks(WeekItem item) {
    if (item.start.isBefore(widget.firstDate) ||
        item.start.isAfter(widget.lastDate)) {
    } else {
      for (int i = 0; i < weekList.length; i++) {
        weekList[i].selected = false;
      }
      item.selected = true;
      startDate = item.start;
      endDate = item.end;
      setState(() {});
    }
  }

  List<DateTime> weekToDayFormat(int year, int week) {
    int dayMills = 24 * 60 * 60 * 1000;
    int weekMills = 7 * dayMills;
    DateTime dateTime = DateTime(year, 1, 4);
    int targetTimeStamp = dateTime.millisecondsSinceEpoch +
        (week * 7 - dateTime.weekday) * dayMills;
    DateTime start = DateTime.fromMillisecondsSinceEpoch(
        targetTimeStamp - weekMills + dayMills);
    DateTime end =
        DateTime.fromMillisecondsSinceEpoch(targetTimeStamp + dayMills - 1);
    return [start, end];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        children: [
          DropButton<int>(
            value: nowDate,
            list: yearList.map((e) => DropItem(title: "$e", value: e)).toList(),
            onChanged: (value) => onChangeYear(value),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              // 每行显示的列数
              childAspectRatio: 1.2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              children: List.generate(
                weekList.length,
                (index) {
                  WeekItem item = weekList[index];
                  return GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: item.selected
                                ? widget.primaryColor
                                : Colors.black12,
                          ),
                          color: item.selected
                              ? widget.primaryColor.withOpacity(.5)
                              : item.color),
                      child: widget.weekWidgetFormat(
                          item.weekNumber, item.start, item.end),
                    ),
                    onTap: () => selectWeeks(item),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(onPressed: onTapWeek, child: const Text("取消")),
              FilledButton(
                  onPressed: onEnterWeekPicker, child: const Text("确定")),
            ],
          )
        ],
      ),
    );
  }
}

class WeekItem {
  int weekNumber;
  DateTime start;
  DateTime end;
  bool selected;
  Color color;

  WeekItem({
    required this.weekNumber,
    required this.start,
    required this.end,
    this.selected = false,
    required this.color,
  });
}
