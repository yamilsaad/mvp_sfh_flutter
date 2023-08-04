import 'package:flutter/material.dart';

class UserImgProvider extends ChangeNotifier {
  List<String> _image = [];

  List<String> get imgUser => _image;

  set imgUser(List<String> newImageUser) {
    _image = newImageUser;
    notifyListeners();
  }
}
