import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:week_pick_button/src/kit/rpx.dart';

import 'config/config.dart';


class Device {
  static String init() {
    //判断是web
    if (Config.BUILD_WEB) {
      String p = Uri.base.queryParameters["p"] ?? "";
      if (p.isEmpty) {
        return "ERR: p is empty ${Uri.base}";
      }

      p = Uri.decodeComponent(p);
      String decoded = utf8.decode(base64Decode(p));

      List<String> arr = decoded.split("┋");
      if (arr.length != 7) {
        return "ERR: $decoded 参数不足 ";
      }

      _statusBarHeight = double.parse(arr[0]);
      _bottomBarHeight = double.parse(arr[1]);
      _padding = double.parse(arr[2]);
      _screenWidth = double.parse(arr[3]);
      _screenHeight = double.parse(arr[4]);
      _isMobile = arr[5] == "true";
      _fdkPort = arr[6];
    } else {
      _fdkPort = "";
      _isMobile = Platform.isAndroid || Platform.isIOS;
    }
    // _isMobile = false;
    return "";
  }

  static bool _isMobile = true;

  static bool get isMobile => _isMobile;

  static late String _fdkPort;

  static String get fdkPort => _fdkPort;

  static late double _statusBarHeight;

  static double get statusBarHeight => _statusBarHeight;

  static late double _bottomBarHeight;

  static double get bottomBarHeight => _bottomBarHeight;

  static late double _padding;

  static double get padding => _padding;

  static late double _screenWidth;

  static double get screenWidth => _screenWidth;

  static late double _screenHeight;

  static double get screenHeight => _screenHeight;

  static bool portrait = true;

  static void screenSize(BuildContext context) {
    //如果是web，就不再继续适配了
    if (Config.BUILD_WEB) {
      return;
    }
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    EdgeInsets padding = mediaQueryData.padding;
    Size size = mediaQueryData.size;

    //bool portrait = isMobile ? mediaQueryData.orientation == Orientation.portrait : true;

    _statusBarHeight = padding.top;

    if (_statusBarHeight < 40) {
      _statusBarHeight += _statusBarHeight / 2.5;
    }

    if (_statusBarHeight >= 48) {
      _statusBarHeight -= _statusBarHeight / 9;
    }

    if (_statusBarHeight == 0) {
      _statusBarHeight = 5.r;
    }

    _bottomBarHeight = padding.bottom;

    //if (portrait) {
    _padding = padding.left;
    /*} else {
      _padding = 0;
    }*/

    _screenWidth = size.width;
    _screenHeight = size.height;
  }
}
