import 'package:flutter/material.dart';

class ButtonSend {
  void _sendData(DateTime dateTime) {
    // Código para enviar los datos
    // Aquí puedes utilizar la variable `dateTime`
    // para realizar el envío de datos con la fecha y hora actual
    print('Enviando datos: $dateTime');
  }

  TextButton buttonSend(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.all(15)),
            backgroundColor:
                MaterialStateColor.resolveWith((states) => Colors.green)),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  title: Text('¿Está seguro de enviar la información?'),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancelar')),
                    TextButton(
                        onPressed: () {
                          //Cerrar el diualogo de confirmacion
                          Navigator.of(context).pop();
                          // Obtener la fecha y hora actual
                          DateTime now = DateTime.now();
                          // Agregar la fecha y hora actual a la información enviada
                          _sendData(now);
                        },
                        child: Text('Ok'))
                  ],
                );
              });
        },
        child: Text('Enviar'));
  }
}
