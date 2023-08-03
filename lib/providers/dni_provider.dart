import 'package:flutter/material.dart';

class DataDniProvider extends ChangeNotifier {
  String _data = '';

  String get dataDni => _data;

  set dataDni(String newData) {
    _data = newData;
    notifyListeners();
  }
}
