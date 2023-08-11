import 'package:flutter/material.dart';

class FormatedDniProvider extends ChangeNotifier {
  String _formatedDni = '';

  String get formatedDni => _formatedDni;

  set formatedDni(String newDni) {
    _formatedDni = newDni;

    notifyListeners();
  }
}
