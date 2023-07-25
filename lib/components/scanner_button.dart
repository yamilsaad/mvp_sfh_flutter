import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../widgets/widget.dart';

class ButtonScannerComponent extends StatefulWidget {
  final Function(String) updateScannedData;

  const ButtonScannerComponent({Key? key, required this.updateScannedData})
      : super(key: key);

  @override
  State<ButtonScannerComponent> createState() => _ButtonScannerComponentState();
}

class _ButtonScannerComponentState extends State<ButtonScannerComponent> {
  String _data = ''; // Variable para almacenar la información formateada.

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.pink,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton(
          elevation: 5,
          hoverElevation: 5.0,
          highlightElevation: 12.0,
          backgroundColor: Colors.pink,
          onPressed: () async {
            String scannedData = await FlutterBarcodeScanner.scanBarcode(
              "#000000",
              "Cancelar",
              true,
              ScanMode.BARCODE,
            );

            if (scannedData != "-1") {
              // Se verifica si no se ha cancelado la operación
              List<String> dataValues = scannedData.split("@");
              String formattedData =
                  "Tramite: ${dataValues[0]}, Apellido: ${dataValues[1]}, Nombre: ${dataValues[2]} Sexo: ${dataValues[3]}, DNI: ${dataValues[4]}, Clase: ${dataValues[5]}, Fecha de vencimiento: ${dataValues[6]} - ${dataValues[7]}, Numero: ${dataValues[8]}";
              setState(() {
                _data =
                    formattedData; // Actualizar el estado con la información formateada.
                widget.updateScannedData(
                    formattedData); // Llamamos a la función updateScannedData con la información formateada.
              });
            }
          },
          child: Icon(
            Icons.qr_code,
            size: 40,
          ),
        ),
      ),
    );
  }
}
