import 'dart:io';

import 'package:flutter/material.dart';

class UserImgProvider extends ChangeNotifier {
  List<File> _image = []; // Cambio aquí

  List<File> get imgUser => _image; // Cambio aquí

  void addImage(File image) {
    _image.add(image);
    notifyListeners();
  }
}
