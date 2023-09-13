import 'package:flutter/material.dart';

import '../dialoges_utils.dart';

abstract class BaseNavigator {
  void showLoadingDialog({String message = "loading ..."});

  void hideLoadingDialog();

  void showMessageDialog(String message,
      {String? posActionName,
      bool isCancelable = true,
      VoidCallback? posAction,
      String? negActionName,
      VoidCallback? negAction});
}

class BaseViewModel<Nav extends BaseNavigator> extends ChangeNotifier {
  Nav? navigator;
}

abstract class BaseState<T extends StatefulWidget, vm extends BaseViewModel>
    extends State<T> implements BaseNavigator {
  late vm viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
    viewModel.navigator = this;
  }

  vm initViewModel();

  @override
  void showLoadingDialog({String message = "loading ..."}) {
    showLoading(context, message);
  }

  @override
  void showMessageDialog(String message,
      {String? posActionName,
      VoidCallback? posAction,
      String? negActionName,
      VoidCallback? negAction,
      bool isCancelable = true}) {
    showMessage(context, message,
        isCancelable: isCancelable,
        negAction: negAction,
        negActionName: negActionName,
        posAction: posAction,
        posActionName: posActionName);
  }

  @override
  void hideLoadingDialog() {
    hideLoading(context);
  }
}
