import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../providers/provider.dart';

class ButtonSend {
  final UserInfoProvider userInfoProvider;
  final BuildContext context; // Agregamos el contexto como parámetro

  ButtonSend(this.userInfoProvider, this.context);

  Future<void> _sendData(DateTime dateTime) async {
    final url = Uri.parse('http://192.168.1.241:8000/api/addcliente');
    final headers = {'Content-Type': 'application/json'};

    final body = {
      //'celular': userInfoProvider.userInfo.celular,
      //'trabajo': userInfoProvider.userInfo.trabajo,
      'infoDni': userInfoProvider.userInfo.infoDni,
      //'foto_usuario': userInfoProvider.userInfo.fotos,
      //'fotos_paper': userInfoProvider.userInfo.imageUrls,
      //'total_recibo': userInfoProvider.userInfo.totalRecibo,
      //'fecha_recibo': userInfoProvider.userInfo.fechaRrecibo,
      //'fecha_info': DateTime.now().toString(),
    };

    print('Enviando datos $body');

    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));
    print('Respuesta del servidor: ${response.statusCode} - ${response.body}');

    if (response.statusCode == 200) {
      print('Información enviada correctamente');
    } else {
      print('Error al enviar la información');
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Error al enviar la información'),
              actions: [
                FloatingActionButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ],
            );
          });
    }
    print('Enviando datos: $dateTime');
  }

  TextButton buttonSend(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.all(15)),
        backgroundColor: MaterialStateColor.resolveWith(
            (states) => const Color.fromARGB(255, 126, 236, 130)),
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
                    print('Enviando información: ${userInfoProvider.userInfo}');
                    _sendData(now);
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
}
