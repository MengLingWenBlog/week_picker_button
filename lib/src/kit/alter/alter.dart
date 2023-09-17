import 'package:flutter/material.dart';
import 'package:week_pick_button/src/kit/rpx.dart';

import '../button_ext.dart';
import '../style.dart';
import '../text_button_ext.dart';


class Alert {
  static Future<bool?> confirm({
    required BuildContext context,
    String? title,
    required String text,
  }) async {
    return showDialog<bool>(
      context: context,
      barrierColor: const Color(0x80000000),
      builder: (BuildContext context) => AlertDialog(
        title: title == null
            ? null
            : Text(
          "• $title",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Style.primaryColor,
          ),
        ),
        titlePadding: EdgeInsets.all(10.r),
        contentPadding: EdgeInsets.symmetric(horizontal: 10.r),
        buttonPadding: EdgeInsets.all(10.r),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10.r),
              child: Icon(
                Icons.notifications_active_outlined,
                size: 36.r,
              ),
            ),
            Text(text),
          ],
        ),
        actions: [
          TextButtonExt(
            title: "取消",
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          ButtonExt(
            title: "确定",
            onPressed: () {
              Navigator.pop(context, true);
            },
          )
        ],
      ),
    );
  }

  static Future<bool?> delete({
    required BuildContext context,
    String? title,
    required String text,
  }) async {
    return showDialog<bool>(
      context: context,
      barrierColor: const Color(0x80000000),
      builder: (BuildContext context) => AlertDialog(
        title: title == null
            ? null
            : Text(
          "• $title",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Style.primaryColor,
          ),
        ),
        titlePadding: EdgeInsets.all(10.r),
        contentPadding: EdgeInsets.symmetric(horizontal: 10.r),
        buttonPadding: EdgeInsets.all(10.r),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10.r),
              child: Icon(
                Icons.delete_forever_outlined,
                size: 36.r,
              ),
            ),
            Text(text),
          ],
        ),
        actions: [
          TextButtonExt(
            title: "取消",
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          ButtonExt(
            title: "删除",
            onPressed: () {
              Navigator.pop(context, true);
            },
          )
        ],
      ),
    );
  }
}
