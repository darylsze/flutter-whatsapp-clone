import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 1,
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.grey[350]),
      ),
    );
  }
}
