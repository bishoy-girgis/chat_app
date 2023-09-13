import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/my_user.dart';

class MyDataBase {
  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter(
            fromFirestore: (doc, _) => MyUser.fromFireStore(doc.data()!),
            toFirestore: (user, options) => user.toFireStore());
  }

  static Future<MyUser?> insertUser(MyUser user) async {
    var coll = getUserCollection();
    var doc = coll.doc(user.id);
    var res = await doc.set(user);
    return user;
  }

  static Future<MyUser?> getUser(String uid) async {
    var coll = getUserCollection();
    var doc = coll.doc(uid);
    var res = await doc.get();
    return res.data();
  }

  static CollectionReference<Room> getRoomCollection() {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .withConverter(
            fromFirestore: (doc, _) => Room.fromFireStore(doc.data()!),
            toFirestore: (room, options) => room.toFireStore());
  }

  static Future<void> createRoom(Room room) {
    var docRef = getRoomCollection().doc();
    room.id = docRef.id;
    return docRef.set(room);
  }

  static Future<List<Room>> loadRooms() async {
    var querySnapShot = await getRoomCollection().get();

    return querySnapShot.docs
        .map((queryDocSnapShot) => queryDocSnapShot.data())
        .toList();
  }

  static CollectionReference<Message> getMessagesCollection(String roomId) {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .doc(roomId)
        .collection(Message.collectionName)
        .withConverter(
            fromFirestore: (doc, _) => Message.fromFireStore(doc.data()!),
            toFirestore: (message, options) => message.toFireStore());
  }

  static Future<void> sendMessage(String roomId, Message message) {
    var messageDoc = getMessagesCollection(roomId).doc();
    message.id = messageDoc.id;
    return messageDoc.set(message);
  }
}
