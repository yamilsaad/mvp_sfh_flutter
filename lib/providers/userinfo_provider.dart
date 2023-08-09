import 'package:flutter/material.dart';
import 'package:mvp_sfh_flutter/models/model.dart';

class UserInfoProvider extends ChangeNotifier {
  UserInfo _userInfo = UserInfo(
      imageUrls: [],
      celular: '',
      fechaRrecibo: '',
      fotos: [],
      infoDni: '',
      totalRecibo: '',
      trabajo: '');

  UserInfo get userInfo => _userInfo;

  set userInfo(UserInfo newUserInfo) {
    _userInfo = newUserInfo;
    notifyListeners();
  }
}
