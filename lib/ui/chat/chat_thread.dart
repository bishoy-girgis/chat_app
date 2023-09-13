import 'package:chat_app/base/base.dart';
import 'package:chat_app/consts/my_theme.dart';
import 'package:chat_app/database/my_database.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/ui/chat/chat_viewmodel.dart';
import 'package:chat_app/ui/chat/message_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/room.dart';

class ChatThread extends StatefulWidget {
  static const String routeName = "chat Thread";

  @override
  State<ChatThread> createState() => _ChatThreadState();
}

class _ChatThreadState extends BaseState<ChatThread, ChatViewModel>
    implements ChatNavigator {
  late Room room;
  TextEditingController messController = TextEditingController();

  @override
  ChatViewModel initViewModel() {
    return ChatViewModel();
  }

  @override
  Widget build(BuildContext context) {
    room = ModalRoute.of(context)?.settings.arguments as Room;
    viewModel.room = room;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage("assets/images/signin.png"),
                  fit: BoxFit.fill)),
          child: Scaffold(
            appBar: AppBar(
              title: Text("${room.title}"),
            ),
            body: Card(
              margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
              color: Colors.white,
              elevation: 18,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  Expanded(
                      child: StreamBuilder<QuerySnapshot<Message>>(
                    stream: MyDataBase.getMessagesCollection(room.id ?? "")
                        .orderBy('dateTime', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("some thing went wrong"),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      var data =
                          snapshot.data?.docs.map((doc) => doc.data()).toList();
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.separated(
                          reverse: true,
                          itemBuilder: (context, index) {
                            return MessageWidget(data![index]);
                          },
                          itemCount: data?.length??0,
                          separatorBuilder: (context, index) => SizedBox(height: 8),
                        ),
                      );
                    },
                  )),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1.3),
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(16))),
                            child: TextField(
                              controller: messController,
                              decoration: const InputDecoration(
                                  hintText: "your message here",
                                  contentPadding: EdgeInsets.all(8)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            viewModel.send(messController.text);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Theme.of(context).primaryColor),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text('Send'),
                              SizedBox(
                                width: 3,
                              ),
                              Icon(
                                Icons.send,
                                size: 18.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  @override
  void clearMess() {
    messController.clear();
  }
}
