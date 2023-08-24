import 'dart:io'; // Agregar esta importación
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import '../providers/provider.dart';

class ButtonSend {
  final UserInfoProvider userInfoProvider;
  final BuildContext context;

  ButtonSend(this.userInfoProvider, this.context);

  Dio dio = Dio();

  Future<void> sendData(DateTime dateTime) async {
    // Agregar dateTime aquí
    try {
      final infoDniProvider = userInfoProvider.userInfo;
      final imageUsuarioProvider = userInfoProvider.userInfo.fotos;

      FormData formData = FormData.fromMap({
        'infoDni': infoDniProvider.infoDni,
        'foto_usuario': imageUsuarioProvider.readAsBytes(),
      });

      Response response = await dio.post(
        'http://192.168.1.241:8000/api/addcliente',
        data: formData,
      );

      if (response.statusCode == 200) {
        print('Enviado correctamente');
      } else {
        print('Error ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

TextButton buttonSend(BuildContext context, ButtonSend buttonSend) {
  // Agregar ButtonSend aquí
  return TextButton(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(EdgeInsets.all(15)),
      backgroundColor: MaterialStateColor.resolveWith(
        (states) => const Color.fromARGB(255, 126, 236, 130),
      ),
    ),
    onPressed: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text('¿Está seguro de enviar la información?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  DateTime now = DateTime.now();
                  print(
                      'Enviando información: ${buttonSend.userInfoProvider.userInfo}');
                  buttonSend.sendData(now); // Llamar al método sendData
                },
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
    },
    child: Text(
      'Enviar información',
      style: TextStyle(color: Colors.white, fontSize: 25),
    ),
  );
}
