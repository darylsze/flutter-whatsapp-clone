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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        left,
        right,
      ],
    );
  }
}
