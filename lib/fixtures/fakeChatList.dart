import 'package:whatsapp_clone/model/Chat.dart';
import 'package:whatsapp_clone/model/MessageState.dart';

List<Chat> fakeChatList = [
  Chat(
    messageState: MessageState.SENDING,
    toUser: 3,
    fromUser: 1,
    message: 'I got good food tonight! 😍',
    updatedAt: DateTime.now(),
    createdAt: DateTime.now(),
  ),
  Chat(
    messageState: MessageState.RECEIVED,
    toUser: 2,
    fromUser: 1,
    message: 'hihi 🤔',
    updatedAt: DateTime.now().subtract(Duration(days: 1)),
    createdAt: DateTime.now().subtract(Duration(days: 1)),
  ),
  Chat(
    messageState: MessageState.READ,
    toUser: 1,
    fromUser: 2,
    message: 'what? 🤔',
    updatedAt: DateTime.now().subtract(Duration(days: 2)),
    createdAt: DateTime.now().subtract(Duration(days: 2)),
  )
];
