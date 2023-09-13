import 'package:chat_app/base/base.dart';
import 'package:chat_app/database/my_database.dart';

import '../../model/room.dart';

abstract class HomeNavigator extends BaseNavigator {}

class HomeViewModel extends BaseViewModel<HomeNavigator> {
  List<Room> rooms = [];

  void loadRooms() async {
    rooms = await MyDataBase.loadRooms();
    notifyListeners();
  }
}
