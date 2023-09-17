import 'package:flutter/material.dart';
import 'package:week_pick_button/src/kit/rpx.dart';

/// 普通按钮
class ButtonExt extends StatelessWidget {
  final Color? color;
  final IconData? iconData;
  final double? iconSize;
  final TextStyle? textStyle;
  final String title;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final VoidCallback? onPressed;

  const ButtonExt({
    Key? key,
    this.color,
    this.iconData,
    this.iconSize,
    this.textStyle,
    required this.title,
    this.padding,
    this.width,
    this.height,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget titleView = Text(
      title,
      style: textStyle,
    );

    Widget child;
    if (iconData != null) {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 2),
            child: Icon(
              iconData,
              size: iconSize ?? 15.r,
              // color: onPressed == null ? Colors.grey : color,
            ),
          ),
          titleView
        ],
      );
    } else {
      child = titleView;
    }

    child = FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: padding == null
            ? null
            : MaterialStateProperty.all<EdgeInsets>(padding!),
        minimumSize:
        padding == null ? null : MaterialStateProperty.all<Size>(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: color == null
            ? null
            : onPressed == null
            ? null
            : MaterialStateColor.resolveWith(
              (states) => color!,
        ),
      ),
      child: child,
    );

    if (width != null || height != null) {
      child = SizedBox(
        width: width,
        height: height,
        child: child,
      );
    }

    return child;
  }
}
