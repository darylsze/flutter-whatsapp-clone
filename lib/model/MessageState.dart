import 'package:flutter/material.dart';

enum MessageState { READ, SENDING, RECEIVING, RECEIVED }

Widget Function(MessageState state) getMessageState = (MessageState state) {
  switch (state) {
    case MessageState.RECEIVED:
      final color = Colors.grey;
      return Text('✓✓', style: TextStyle(color: color, fontSize: 18));
    case MessageState.READ:
      final color = Colors.green[700];
      return Text('✓✓', style: TextStyle(color: color, fontSize: 18));
    case MessageState.RECEIVING:
      final color = Colors.grey;
      return Text('✓', style: TextStyle(color: color, fontSize: 18));
    case MessageState.SENDING:
    default:
      final color = Colors.grey[400];
      return Icon(
        Icons.access_time,
        color: color,
        size: 17,
      );
  }
};
