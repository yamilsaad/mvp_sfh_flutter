import 'package:flutter/material.dart';

class SendDataProvider extends ChangeNotifier {
  Map<String, dynamic> _sendData = {};

  Map<String, dynamic> get dataSend => _sendData;

  set dataSend(Map<String, dynamic> newMap) {
    _sendData = newMap;
    notifyListeners();
  }
}
