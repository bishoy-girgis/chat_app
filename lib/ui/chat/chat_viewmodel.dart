import 'package:chat_app/base/base.dart';
import 'package:chat_app/database/my_database.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/shared_data.dart';

import '../../model/room.dart';

abstract class ChatNavigator extends BaseNavigator {
  void clearMess() {}
}

class ChatViewModel extends BaseViewModel<ChatNavigator> {
  late Room room;

  void send(String messageContent) {
    if(messageContent.trim().isEmpty)return;
    var message = Message(
        content: messageContent,
        senderName: SharedData.user?.userName,
        senderId: SharedData.user?.id,
        roomId: room.id,
        dateTime: DateTime.now().microsecondsSinceEpoch);
    MyDataBase.sendMessage(room.id ?? "", message)
        .then((value) => navigator?.clearMess())
        .onError((error, stackTrace) {
      navigator?.showMessageDialog("something went wrong",
        posActionName: "try again",
        posAction: () => send(messageContent),
        negActionName: "cancel",
      );
    });
  }
}
