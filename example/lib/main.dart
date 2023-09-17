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
  @override
  void initState() {
    super.initState();
  }

  void onChangeWeek(value) {
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: WeekPickerButton(
            initialDate: DateTime.now(),
            firstDate: "2021",
            lastDate: "2024",
            onChanged: onChangeWeek,
          ),
        ),
      ),
    );
  }
}
