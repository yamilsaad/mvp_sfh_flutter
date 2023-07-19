import 'package:flutter/material.dart';

import '../components/component.dart';
import '../layouts/layout.dart';

class NewClientScreen extends StatelessWidget {
  const NewClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void _sendData() async {
      // Aquí armarías el mapa con la información que deseas enviar al web service
      final body = {
        //'DOMICILIO1': selectedLocalidad,
        //'celular': celularController.text,
        //'infoDni': scannedData,
        // Otros campos...
      };

      // El código para enviar el mapa al web service...
      // Puedes utilizar la función _sendData que ya has proporcionado y adaptarla aquí.
    }

    // Variable para almacenar la información escaneada
    String scannedData = '';

    return Scaffold(
        appBar: AppBar(
          title: Text('Nuevo Cliente'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              NewClientLayout(),
            ],
          ),
        ),
        //Botón de Scanner en barra inferior:
        bottomNavigationBar: ButtonScannerComponent(
          updateScannedData: (String data) {
            // Guardar la información escaneada en la variable scannedData
            scannedData = data;
          },
        ));
  }
}
