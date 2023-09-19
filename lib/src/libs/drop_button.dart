import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropButton<T> extends StatefulWidget {
  final T? value;
  final double? width;
  final List<DropItem<T>> list;
  final void Function(T)? onChanged;

  const DropButton({
    super.key,
    required this.list,
    this.value,
    this.width,
    this.onChanged,
  });

  @override
  State<DropButton<T>> createState() => _DropButtonState<T>();
}

class _DropButtonState<T> extends State<DropButton<T>> {
  T? v;
  bool _innerState = false;

  @override
  Widget build(BuildContext context) {
    if (widget.value == null) {
      v = widget.list.first.value;
    } else {
      if (_innerState) {
        _innerState = false;
      } else {
        v = widget.value;
      }
    }

    Widget child = DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        isExpanded: widget.width == null ? false : true,
        hint: const Text('请选择'),
        items: widget.list
            .map(
              (DropItem<T> e) => DropdownMenuItem<T>(
                alignment: Alignment.center,
                value: e.value,
                child: Text(e.title),
              ),
            )
            .toList(),
        value: v,
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.zero,
        ),
        dropdownStyleData: const DropdownStyleData(
          padding: EdgeInsets.zero,
          scrollPadding: EdgeInsets.zero,
        ),
        onChanged: widget.onChanged == null
            ? null
            : (T? value) {
                if (value == null) {
                  return;
                }
                v = value;
                _innerState = true;
                widget.onChanged?.call(value);
                setState(() {});
              },
      ),
    );
    if (widget.width != null) {
      child = SizedBox(
        width: widget.width,
        child: child,
      );
    }
    return child;
  }
}

class DropItem<T> {
  String title;
  T value;

  DropItem({
    required this.title,
    required this.value,
  });
}
