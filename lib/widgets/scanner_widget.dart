import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../UI/ui.dart';
import '../alerts/alert.dart';

//*Lógica del Scanner
class ScannerWidget extends StatefulWidget {
  const ScannerWidget({super.key});

  @override
  State<ScannerWidget> createState() => _ScannerWidgetState();
}

class _ScannerWidgetState extends State<ScannerWidget> {
  //Efecto de visibilidad de contenedor de info scaneada del DNI:
  bool _isContainerVisible = false;
  //Variable donde se guarda la información Scaneada:
  String _data = "";

  Future<void> _scan() async {
    try {
      String scannedData = await FlutterBarcodeScanner.scanBarcode(
          "#000000", "Cancel", true, ScanMode.BARCODE);
      if (scannedData != "-1") {
        // Se verifica si no se ha cancelado la operación
        List<String> dataValues = scannedData.split("@");
        String formattedData =
            "Tramite: ${dataValues[0]}, Apellido: ${dataValues[1]}, Nombre: ${dataValues[2]} Sexo: ${dataValues[3]}, DNI: ${dataValues[4]}, Clase: ${dataValues[5]}, Fecha de vencimiento: ${dataValues[6]} - ${dataValues[7]}, Numero: ${dataValues[8]}";
        setState(() => _data = formattedData);

        // Realizar la petición GET para verificar si el cliente ya existe
        final dni = dataValues[4];
        final url = Uri.parse(
            'http://192.168.1.102:8080/datasnap/rest/TSFHWebSvr/cliente/$dni');
        final response = await http.get(url);
        if (response.statusCode == 200) {
          // El web service respondió correctamente
          final jsonResponse = jsonDecode(response.body);
          final clienteExistente = jsonResponse['result'];
          if (clienteExistente != null && clienteExistente) {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text("Cliente existente"),
                content: Text(
                    "El cliente con DNI $dni ya existe en la base de datos."),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("OK"),
                  ),
                ],
              ),
            );
          } else {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text("Agregar cliente"),
                content: Text(
                    "El cliente con DNI $dni no existe en la base de datos. Debe agregarlo."),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("OK"),
                  ),
                ],
              ),
            );
          }
        } else {
          // El web service respondió con un error
          //await DialogService.showAlertDialog(context);
          print('Error al verificar si el cliente existe');
          return;
        }
      }
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        // El usuario ha rechazado el permiso
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Error"),
            content:
                Text("El permiso para acceder a la cámara ha sido denegado."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          ),
        );
      } else {
        //* El web service respondió con un error
        await AlertScanner.showErrorDialog(
            context, "Ha ocurrido un error al intentar escanear el código.");
        print('Error al verificar si el cliente existe');
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //El widget Visibility permite esconder el contenedor hasta que sea utilizado!
    return Visibility(
        visible: _isContainerVisible, child: InfoDniWidget(data: _data));
  }
}
