import 'package:flutter/material.dart';

class SafeHeader extends PreferredSize {
  Widget child;
  num height;
  SafeHeader({this.child, this.height});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: child),
    );
  }
}
