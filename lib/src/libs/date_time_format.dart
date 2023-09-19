import 'package:jiffy/jiffy.dart';

class DateTimeFormat {
  static String toStr(DateTime dateTime, String pattern) {
    return Jiffy.parseFromDateTime(dateTime).format(pattern: pattern);
  }
}
