import 'package:flutter/material.dart';
import 'package:week_pick_button/src/kit/rpx.dart';

import 'empty.dart';


/// 文本按钮
class TextButtonExt extends StatelessWidget {
  final Color? color;
  final IconData? iconData;
  final double? iconSize;
  final String? title;
  final int? maxLines;
  final double? titleSize;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final VoidCallback? onPressed;

  const TextButtonExt({
    Key? key,
    this.color,
    this.iconData,
    this.iconSize,
    this.title,
    this.maxLines,
    this.titleSize,
    this.padding,
    this.width,
    this.height,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? titleView;
    if (title != null) {
      titleView = Text(
        title!,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: onPressed == null ? Colors.grey : color,
          fontWeight: FontWeight.normal,
          fontSize: titleSize,
        ),
      );
    }

    Widget? iconView;
    if (iconData != null) {
      iconView = Padding(
        padding:
        title == null ? EdgeInsets.all(5.r) : EdgeInsets.only(right: 2.r),
        child: Icon(
          iconData,
          size: iconSize ?? 15.r,
          color: onPressed == null ? Colors.grey : color,
        ),
      );
    }

    Widget child;
    if (titleView != null && iconView != null) {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [iconView, titleView],
      );
    } else if (titleView != null) {
      child = titleView;
    } else if (iconView != null) {
      child = iconView;
    } else {
      return Empty.widget;
    }

    child = TextButton(
      style: ButtonStyle(
        padding: padding == null
            ? null
            : MaterialStateProperty.all<EdgeInsetsGeometry?>(padding),
        minimumSize: padding == null
            ? null
            : MaterialStateProperty.all<Size?>(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        overlayColor: color == null || onPressed == null
            ? null
            : MaterialStateColor.resolveWith(
              (states) => color!.withOpacity(.1),
        ),
      ),
      onPressed: onPressed,
      child: child,
      //child: Text("xx"),
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
