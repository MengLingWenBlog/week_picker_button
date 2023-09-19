import 'package:flutter/material.dart';

class AlertView {
  final BuildContext context;
  final Widget? title;
  final Widget content;
  final List<Widget>? actions;
  final Color? barrierColor;
  final Color? backgroundColor;

  const AlertView({
    this.title,
    required this.context,
    required this.content,
    this.actions,
    this.barrierColor,
    this.backgroundColor,
  });

  Future<T?> show<T>() {
    return showDialog<T>(
      context: context,
      barrierDismissible: false,
      barrierColor: barrierColor ?? const Color(0x80000000),
      builder: (BuildContext context) => AlertDialog(
        title: title,
        backgroundColor: backgroundColor,
        // backgroundColor: Colors.white,
        //titlePadding: const EdgeInsets.all(15),
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: content,
        actions: actions,
        actionsAlignment: MainAxisAlignment.spaceAround,
      ),
    );
  }
}
