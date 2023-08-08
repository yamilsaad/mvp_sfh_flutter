import 'package:flutter/material.dart';

class ButtonSendProvider extends ChangeNotifier {
  Map _sendData = {};

  Map get dataSend => _sendData;

  set dataSend(Map newMap) {
    _sendData = newMap;
    notifyListeners();
  }
}
