import 'device.dart';

extension RpxExtension on num {
  double get r {
    return Rpx.getPx(toDouble());
  }
}

class Rpx {
  static double _rpx = 1;
  static double _scale = 1;
  static late double _designWidth;
  static late double _standardWidth;

  static void init({
    //设计稿宽度
    double designWidth = 375,
    //标准宽度
    double standardWidth = 750,
  }) {
    _designWidth = designWidth;
    _standardWidth = standardWidth;

    if (Device.screenWidth == 0 || Device.screenHeight == 0) {
      print("device size is empty");
      return;
    }
    _scale = _standardWidth / _designWidth;

    _rpx = Device.screenWidth < Device.screenHeight
        //竖屏
        ? Device.screenWidth / _standardWidth
        //横屏
        : Device.screenHeight / _standardWidth;
    return;
  }

  static double getPx(double size) {
    return _rpx * size * _scale;
  }
}
