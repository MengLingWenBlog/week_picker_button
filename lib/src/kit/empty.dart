import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:week_pick_button/kit/rpx.dart';


class Empty {
  static const SizedBox widget = SizedBox.shrink();
  static SpinKitCubeGrid loading = const SpinKitCubeGrid(
    color: Colors.black,
  );

  static SizedBox logo({double? size}) {
    size ??= 100.r;
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset(
        "images/logo.png",
        fit: BoxFit.contain,
      ),
    );
  }
}
