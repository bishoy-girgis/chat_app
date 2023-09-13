import 'package:chat_app/model/message.dart';
import 'package:chat_app/shared_data.dart';
import 'package:chat_app/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  Message message;

  MessageWidget(this.message);

  @override
  Widget build(BuildContext context) {
    return message.senderId == SharedData.user?.id
        ? SentMessage(message.dateTime!, message.content!)
        : RecieveMessage(message.senderName!, message.dateTime!, message.content!);
  }
}

class SentMessage extends StatelessWidget {
  int dateTime;
  String content;

  SentMessage(this.dateTime, this.content);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
                //topRight: Radius.circular(26),
                bottomLeft: Radius.circular(22),
                bottomRight: Radius.circular(22),
                topLeft: Radius.circular(22)),
          ),
          child: Text(content,
              style: const TextStyle(fontSize: 16, color: Colors.white)),
        ),
        Text("${formatMessageDate(dateTime)}",
            style: const TextStyle(fontSize: 12, color: Color(0Xff282F39)))
      ],
    );
  }
}

class RecieveMessage extends StatelessWidget {
  int dateTime;
  String content;
  String senderName;

  RecieveMessage(this.senderName, this.dateTime, this.content);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(senderName,
            style:  TextStyle(fontSize: 14, color:Theme.of(context).primaryColor)),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Color(0XFFF8F8F8),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(26),
                bottomLeft: Radius.circular(26),
                bottomRight: Radius.circular(26)),
          ),
          child: Text(content,
              style: const TextStyle(fontSize: 16, color: Color(0XFF787993))),
        ),
        Text("${formatMessageDate(dateTime)}",
            style: const TextStyle(fontSize: 12, color: Color(0Xff282F39)))
      ],
    );
  }
}
