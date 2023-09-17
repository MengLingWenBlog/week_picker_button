import 'package:jiffy/jiffy.dart';

class DateTimeFormat {
  static String toStr(DateTime dateTime, String pattern) {
    return Jiffy.parseFromDateTime(dateTime).format(pattern: pattern);
  }

  static DateTime toDateTime(String dateTime) {
    return DateTime.parse(dateTime);
  }

  static DateTime add(
      DateTime dateTime, {
        int years = 0,
        int months = 0,
        int weeks = 0,
        int days = 0,
        int hours = 0,
        int minutes = 0,
        int seconds = 0,
      }) {
    return Jiffy.parseFromDateTime(dateTime)
        .add(
      years: years,
      months: months,
      weeks: weeks,
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
    )
        .dateTime;
  }

  static DateTime subtract(
      DateTime dateTime, {
        int years = 0,
        int months = 0,
        int weeks = 0,
        int days = 0,
        int hours = 0,
        int minutes = 0,
        int seconds = 0,
      }) {
    return Jiffy.parseFromDateTime(dateTime)
        .subtract(
      years: years,
      months: months,
      weeks: weeks,
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
    )
        .dateTime;
  }

  static String fromNow(DateTime dateTime) {
    return Jiffy.parseFromDateTime(dateTime).fromNow();
  }

  //某季度的起始日期和结束日期
  static List<String> rangeOfQuarter(DateTime dateTime) {
    /*
    int q = jiffy.quarter;
    //开始和结束月份
    String start = ((q - 1) * 3 + 1).toString().padLeft(2, "0");
    //结束月份的日
    String endOfQuarter = Jiffy.parse("${jiffy.year}-${q * 3} ", pattern: 'yyyy-M')
        .endOf(Unit.month)
        .format(pattern: 'yyyy-MM-dd');
    //季度的开始和结束日期
    return [
      "${jiffy.year}-$start-01",
      endOfQuarter,
    ];*/
    int year = dateTime.year;
    switch (Jiffy.parseFromDateTime(dateTime).quarter) {
      case 1:
        return ["$year-01-01", "$year-03-31"];
      case 2:
        return ["$year-04-01", "$year-06-30"];
      case 3:
        return ["$year-07-01", "$year-09-30"];
      case 4:
        return ["$year-10-01", "$year-12-31"];
    }
    return [];
  }

  //某年年的开始和结束
  static List<String> rangeOfYear(DateTime dateTime) {
    int year = dateTime.year;
    return ["$year-01-01", "$year-12-31"];
  }
}
