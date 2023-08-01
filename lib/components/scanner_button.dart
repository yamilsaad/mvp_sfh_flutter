import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;

import '../configs/config.dart';
import '../widgets/widget.dart';

class ButtonScannerComponent extends StatefulWidget {
  final Function(String) updateScannedData;

  const ButtonScannerComponent({Key? key, required this.updateScannedData})
      : super(key: key);

  @override
  State<ButtonScannerComponent> createState() => _ButtonScannerComponentState();
}

class _ButtonScannerComponentState extends State<ButtonScannerComponent> {
  String _data = '';

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
          onPressed: _scanDocument,
          child: Icon(
            Icons.qr_code,
            size: 40,
          ),
        ),
      ),
    );
  }

  void _scanDocument() async {
    String scannedData = await FlutterBarcodeScanner.scanBarcode(
      "#000000",
      "Cancelar",
      true,
      ScanMode.BARCODE,
    );

    if (scannedData != "-1") {
      List<String> dataValues = scannedData.split("@");
      String formattedData =
          "Tramite: ${dataValues[0]}, Apellido: ${dataValues[1]}, Nombre: ${dataValues[2]} Sexo: ${dataValues[3]}, DNI: ${dataValues[4]}, Clase: ${dataValues[5]}, Fecha de vencimiento: ${dataValues[6]} - ${dataValues[7]}, Numero: ${dataValues[8]}";

      final dni = dataValues[4];
      await _fetchClienteInfo(dni, formattedData);
    }
  }

  Future<void> _fetchClienteInfo(String dni, String formattedData) async {
    final url = Uri.parse('${ScannerConfig.apiUrl}/api/clientes/$dni');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse.containsKey('APELLIDO') &&
            jsonResponse.containsKey('NOMBRE')) {
          String apellido = jsonResponse['APELLIDO'];
          String nombre = jsonResponse['NOMBRE'];
          String clienteInfo = 'Nombre: $nombre, Apellido: $apellido';

          _showClienteEncontradoDialog(clienteInfo);
        } else {
          _showClienteNoEncontradoDialog(dni);
        }
      } else {
        _showErrorDialog(
            'Error en el servidor', 'No se pudo conectar al web service.');
      }
    } catch (e) {
      _showErrorDialog(
          'Error', 'Hubo un error al realizar la petición al servidor.');
    }
  }

  void _showClienteEncontradoDialog(String clienteInfo) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Cliente encontrado"),
        content: Text(clienteInfo),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showClienteNoEncontradoDialog(String dni) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Cliente no encontrado"),
        content: Text("El cliente con DNI $dni no existe en la base de datos."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}
