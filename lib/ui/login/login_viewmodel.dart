import 'package:chat_app/base/base.dart';
import 'package:chat_app/database/my_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../shared_data.dart';

abstract class LoginNavigator extends BaseNavigator {
  void goToHome();
}

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  var authService = FirebaseAuth.instance;

  void login(String email, String pass) async {
    navigator?.showLoadingDialog();
    try {
      var credential = await authService.signInWithEmailAndPassword(
          email: email, password: pass);
      var retrievedUser =await MyDataBase.getUser(credential.user?.uid ?? "");

      navigator?.hideLoadingDialog();
      if(retrievedUser==null){
        navigator?.showMessageDialog("something went wrong \n user name or password");
      }else{
        SharedData.user = retrievedUser;
        navigator?.goToHome();
      }

    } on FirebaseAuthException catch (e) {
      navigator?.hideLoadingDialog();
      navigator?.showMessageDialog("wrong user name or password");
    }
  }

  void checkedLoginUser()async{
    if(authService.currentUser!=null){
      var retrievedUser =await MyDataBase.getUser(authService.currentUser?.uid ?? "");
      SharedData.user = retrievedUser;
      navigator?.goToHome();

    }
  }
}
