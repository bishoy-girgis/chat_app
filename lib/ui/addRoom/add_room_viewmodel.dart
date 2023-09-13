import 'package:chat_app/base/base.dart';
import 'package:chat_app/database/my_database.dart';
import 'package:chat_app/model/room.dart';

abstract class AddRoomNavigator extends BaseNavigator {
  void goBack();
}

class AddRoomViewModel extends BaseViewModel<AddRoomNavigator> {
  void addRoom(String title, String description, String catId) async {
    navigator?.showLoadingDialog(message: "creating room ...");
    try {
      var res = await MyDataBase.createRoom(
          Room(title: title, catId: catId, description: description));
      navigator?.hideLoadingDialog();
      navigator?.showMessageDialog(
        "Room created successfully",
        posActionName: "ok",
        posAction: () {
          navigator?.goBack();

        },
          isCancelable: false
      );
    } catch (e) {
      navigator?.hideLoadingDialog();
      navigator?.showMessageDialog("something went wrong ${e.toString()}");
    }
  }
}
