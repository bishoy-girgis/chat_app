import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/room.dart';
import '../chat/chat_thread.dart';

class RoomWidget extends StatelessWidget {
  Room room;

  RoomWidget(this.room);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ChatThread.routeName,arguments: room);
      },
      child: Card(
        margin: EdgeInsets.all(14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 18,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          child: Column(
            children: [
              Expanded(
                  child: Image.asset(
                "assets/images/${room.catId}.png",
                fit: BoxFit.fill,
              )),
              SizedBox(
                height: 5,
              ),
              Text("${room.title}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}
