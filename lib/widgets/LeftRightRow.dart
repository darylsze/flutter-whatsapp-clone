import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LeftRightRow extends StatelessWidget {
  const LeftRightRow({
    Key key,
    this.left,
    this.right,
  }) : super(key: key);

  final Widget left;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    final childs = [left, right]..removeWhere((widget) => widget == null);
    if (left == null || right == null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: childs,
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: childs,
    );
  }
}
