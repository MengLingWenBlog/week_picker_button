import 'package:flutter/material.dart';
import "package:week_pick_button/week_pick_button.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: WeekPickerButton(
            initialDate: now,
            firstDate: DateTime(now.year - 1, 1, 1),
            lastDate: DateTime(now.year + 1, 1, 1),
            onChanged: (value) {
              print(value);
            },
          ),
        ),
      ),
    );
  }
}
