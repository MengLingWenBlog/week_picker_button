import 'package:flutter/material.dart';
import 'package:week_pick_button/src/kit/rpx.dart';
import 'kit/button_ext.dart';
import 'kit/date_time_format.dart';
import 'kit/drop_button.dart';
import 'kit/text_button_ext.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WeekPicker extends StatefulWidget {
  final DateTime initialDate;
  final String firstDate;
  final String lastDate;
  final ValueChanged<String>? onChanged;

  const WeekPicker({
    Key? key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    this.onChanged,
  }) : super(key: key);

  @override
  State<WeekPicker> createState() => _WeekPickerState();
}

class _WeekPickerState extends State<WeekPicker> {
  List<WeekItem> weekList = []; //GridView的数据源

  String nowDate = ""; //初始是当前年份,之后是选择的年份

  // int weekNumber = 0; //一年内有多少个周

  int selectWeekNumber = 0; //选中的是第几周

  int nowWeekNumber = 0; //当前时间是第几周

  String startDate = ""; //开始时间

  String endDate = ""; //结束时间

  List<String> yearList = []; //年份列表

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    nowDate = DateTimeFormat.toStr(widget.initialDate, "yyyy"); // 初始化当前年份

    nowWeekNumber = getWeekNumber(widget.initialDate); //初始化当前是第几周

    List<String> weekToDay = weekToDayFormat(int.parse(nowDate), nowWeekNumber);

    startDate = weekToDay[0];

    endDate = weekToDay[1];

    getYearList();
    _getData("");
  }

  //获取初始化年份数据
  void getYearList() {
    int firstYear = int.parse(widget.firstDate);
    int lastYear = int.parse(widget.lastDate);
    for (int i = firstYear; i < lastYear + 1; i++) {
      yearList.add("$i");
    }
  }

  //年份改变
  void onChangeYear(value) {
    nowDate = value;
    startDate = "";
    endDate = "";
    _getData("tab");
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
  void _getData(String tap) {
    int weekNumberIndex = getWeekNumber(DateTime.now()); //当前时间是第几周

    int weekNumber = numOfWeeks(int.parse(nowDate)); //选中的时间有多少个周

    weekList.clear();
    for (int i = 1; i < weekNumber + 1; i++) {
      List<String> list =
          weekToDayFormat(int.parse(nowDate), i); //每个周的开始时间和结束时间
      if (nowDate == DateTimeFormat.toStr(DateTime.now(), "yyyy")) {
        //判断是不是当前年份
        if (tap.isNotEmpty) {
          nowWeekNumber = weekNumberIndex;
        }
        weekList.add(
          WeekItem(
              weekNumber: i,
              start: list[0],
              end: list[1],
              color: nowWeekNumber == i
                  ? Colors.red
                  : i > weekNumberIndex
                      ? Colors.grey
                      : Colors.white),
        );
      } else if (int.parse(nowDate) >
          int.parse(DateTimeFormat.toStr(DateTime.now(), "yyyy"))) {
        weekList.add(
          WeekItem(
            weekNumber: i,
            start: list[0],
            end: list[1],
            color: Colors.grey,
          ),
        );
      } else {
        if (tap.isNotEmpty) {
          weekList.add(
            WeekItem(
              weekNumber: i,
              start: list[0],
              end: list[1],
              color: Colors.white,
            ),
          );
        } else {
          weekList.add(
            WeekItem(
              weekNumber: i,
              start: list[0],
              end: list[1],
              color: nowWeekNumber == i ? Colors.red : Colors.white,
            ),
          );
        }
      }
    }
    setState(() {});
  }

  //取消
  void onTapWeek() {
    Navigator.pop(context);
  }

  //确定
  void onEnterWeekPicker() {
    if (startDate.isEmpty || endDate.isEmpty) {
      Fluttertoast.showToast(
          msg: "请选择时间",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      widget.onChanged?.call("$nowDate-$startDate");
      Navigator.pop(context);
    }
  }

  //选择
  void selectWeeks(WeekItem item) {
    if (nowDate == DateTimeFormat.toStr(DateTime.now(), "yyyy")) {
      if (item.color == Colors.grey) {
        // Toast.info("不可选");
        Fluttertoast.showToast(
            msg: "不可选",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        int nowWeekNumberIndex = getWeekNumber(DateTime.now());
        for (int i = 0; i < nowWeekNumberIndex; i++) {
          weekList[i].color = Colors.white;
        }
        item.color = Colors.red;
        startDate = item.start;
        endDate = item.end;
        setState(() {});
      }
    } else {
      if (item.color == Colors.grey) {
        // Toast.info("不可选");
        Fluttertoast.showToast(
            msg: "不可选",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        for (int i = 0; i < weekList.length; i++) {
          weekList[i].color = Colors.white;
        }
        item.color = Colors.red;
        startDate = item.start;
        endDate = item.end;
        setState(() {});
      }
    }
  }

  List<String> weekToDayFormat(int year, int week) {
    int dayMills = 24 * 60 * 60 * 1000;
    int weekMills = 7 * dayMills;
    DateTime dateTime = DateTime(year, 1, 4);
    int targetTimeStamp = dateTime.millisecondsSinceEpoch +
        (week * 7 - dateTime.weekday) * dayMills;
    String start = DateTimeFormat.toStr(
        DateTime.fromMillisecondsSinceEpoch(
            targetTimeStamp - weekMills + dayMills),
        "MM-dd");
    String end = DateTimeFormat.toStr(
        DateTime.fromMillisecondsSinceEpoch(targetTimeStamp + dayMills - 1),
        "MM-dd");
    return [start, end];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.r,
      height: 400.r,
      padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 20.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
      ),
      child: Column(
        children: [
          DropButton<String>(
            value: nowDate,
            width: 95.r,
            list:
                yearList.map((e) => DropItem(title: "$e年", value: e)).toList(),
            onChanged: (value) => onChangeYear(value),
          ),
          Expanded(
            child: GridView.count(
              controller: ScrollController(
                initialScrollOffset: nowWeekNumber > 6 &&
                        nowDate == DateTimeFormat.toStr(DateTime.now(), "yyyy")
                    ? 80.r * (nowWeekNumber / 3)
                    : 0.r,
              ),
              crossAxisCount: 3,
              // 每行显示的列数
              childAspectRatio: 1,
              crossAxisSpacing: 5.r,
              mainAxisSpacing: 5.r,
              children: List.generate(
                weekList.length,
                (index) {
                  WeekItem item = weekList[index];
                  return GestureDetector(
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5.r,
                              color: nowDate ==
                                          DateTimeFormat.toStr(
                                              DateTime.now(), "yyyy") &&
                                      index + 1 == getWeekNumber(DateTime.now())
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                            color: item.color),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "第${(item.weekNumber)}周",
                            ),
                            Text(
                              "周一:${item.start}",
                            ),
                            Text(
                              "周日:${item.end}",
                            ),
                          ],
                        )),
                    onTap: () => selectWeeks(item),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 10.r,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("开始时间:$startDate"),
              Text("结束时间:$endDate"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButtonExt(title: "取消", onPressed: onTapWeek),
              ButtonExt(
                title: "确定",
                onPressed: onEnterWeekPicker,
              )
            ],
          )
        ],
      ),
    );
  }
}

class WeekItem {
  int weekNumber;
  String start;
  String end;
  Color color;

  WeekItem({
    required this.weekNumber,
    required this.start,
    required this.end,
    required this.color,
  });
}
