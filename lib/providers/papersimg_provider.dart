import 'dart:io';
import 'package:flutter/material.dart';

class PapersImgProvider extends ChangeNotifier {
  List<File> _image = [];

  List<File> get imgPapers => _image;

  void addImg(File image) {
    _image.add(image);
    notifyListeners();
  }
}
