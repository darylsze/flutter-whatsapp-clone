import 'package:whatsapp_clone/model/Chat.dart';
import 'package:whatsapp_clone/model/MessageState.dart';
import 'package:whatsapp_clone/utils/timeUtil.dart';

List<Chat> fakeConversation = [
  Chat(
    uuid: 1,
    toUser: 2,
    fromUser: 1,
    message: 'so what?',
    createdAt: getTodayAt(hour: 10, min: 39, sec: 1),
    updatedAt: getTodayAt(hour: 10, min: 39, sec: 1),
    messageState: MessageState.READ,
  ),
  Chat(
    uuid: 2,
    toUser: 1,
    fromUser: 2,
    message: 'We may undergo a risk',
    createdAt: getTodayAt(hour: 10, min: 39, sec: 10),
    updatedAt: getTodayAt(hour: 10, min: 39, sec: 10),
    messageState: MessageState.NONE,
  ),
  Chat(
    uuid: 3,
    toUser: 1,
    fromUser: 2,
    message: 'Not sure of the success',
    createdAt: getTodayAt(hour: 10, min: 39, sec: 20),
    updatedAt: getTodayAt(hour: 10, min: 39, sec: 20),
    messageState: MessageState.NONE,
  ),
  Chat(
    uuid: 4,
    toUser: 2,
    fromUser: 1,
    message: 'we may succeed',
    createdAt: getTodayAt(hour: 10, min: 39, sec: 35),
    updatedAt: getTodayAt(hour: 10, min: 39, sec: 35),
    messageState: MessageState.READ,
  ),
  Chat(
    uuid: 5,
    toUser: 1,
    fromUser: 2,
    message: '// todo video clip',
    createdAt: getTodayAt(hour: 11, min: 13, sec: 15),
    updatedAt: getTodayAt(hour: 11, min: 13, sec: 15),
    messageState: MessageState.NONE,
  ),
  Chat(
    uuid: 6,
    toUser: 2,
    fromUser: 1,
    message:
        'Its okay. Lets not be doomed by these risks. Its better to fail after try then to sit without trying.',
    createdAt: getTodayAt(hour: 11, min: 15, sec: 15),
    updatedAt: getTodayAt(hour: 11, min: 15, sec: 15),
    messageState: MessageState.SENDING,
    replyFrom: 5,
  ),
];
