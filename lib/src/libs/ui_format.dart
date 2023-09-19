import 'package:flutter/widgets.dart';

typedef WeekWidgetFormat = Widget Function(
    int week, DateTime monday, DateTime sunday);

typedef ButtonTextFormat = String Function(int year, int week);
