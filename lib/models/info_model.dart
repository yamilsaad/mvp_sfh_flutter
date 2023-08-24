import 'package:flutter/material.dart';
import 'dart:io';

class UserInfo {
  String celular;
  String trabajo;
  String infoDni;
  List<String> imageUrls; // Cambio aquí
  File fotos; // También aquí
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
