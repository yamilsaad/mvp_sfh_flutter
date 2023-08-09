import 'package:flutter/material.dart';

class UserInfo {
  String celular;
  String trabajo;
  String infoDni;
  List<FileImage> imageUrls;
  List<FileImage> fotos;
  String fechaRrecibo;
  String totalRecibo;

  UserInfo({
    required this.celular,
    required this.trabajo,
    required this.infoDni,
    required this.imageUrls,
    required this.fotos,
    required this.fechaRrecibo,
    required this.totalRecibo,
  });
}
