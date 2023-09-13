import 'package:chat_app/base/base.dart';
import 'package:chat_app/database/my_database.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/shared_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class RegisterNavigator extends BaseNavigator {
  void goToHome();
}

class RegisterViewModel extends BaseViewModel<RegisterNavigator> {
  var authService = FirebaseAuth.instance;

  void register(String email, String pass,String userName,String fullName) async {
    navigator?.showLoadingDialog();
    try {
      var credential = await authService.createUserWithEmailAndPassword(
          email: email, password: pass);
      MyUser newUser = MyUser(
        userName: userName,
        fullName: fullName,
        email: email,
        id: credential.user?.uid
      );
      var insertedUser = await MyDataBase.insertUser(newUser);
      navigator?.hideLoadingDialog();
      if(insertedUser!=null){
        SharedData.user = insertedUser;
        navigator?.goToHome();
      }else{
        navigator?.showMessageDialog("something went wrong in database ");
      }
    } on FirebaseAuthException catch (e) {
      navigator?.hideLoadingDialog();
      if (e.code == "weak-password") {
        navigator?.showMessageDialog("the password provided is too weak");
      } else if (e.code == "email-already-in-use") {
        navigator?.showMessageDialog("email is alraedy registered before");
      }
    }
  }
}
