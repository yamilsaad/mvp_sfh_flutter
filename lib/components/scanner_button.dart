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
          onPressed: () async {
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
              final url =
                  Uri.parse('${ScannerConfig.apiUrl}/api/clientes/$dni');
              try {
                final response = await http.get(url);
                if (response.statusCode == 200) {
                  final jsonResponse = jsonDecode(response.body);
                  if (jsonResponse.containsKey('success')) {
                    if (jsonResponse['success']) {
                      // Cliente encontrado
                      Map<String, dynamic> datosPersonales =
                          jsonResponse['datos_personales'];
                      String apellido = datosPersonales['APELLIDO'];
                      String nombre = datosPersonales['NOMBRE'];
                      String clienteInfo =
                          'Nombre: $nombre, Apellido: $apellido';

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
                    } else if (dni == false) {
                      // Cliente no encontrado
                      String errorMessage =
                          jsonResponse['message'] ?? "Cliente no encontrado";
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text("Cliente no encontrado"),
                          content: Text(errorMessage),
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
                    // Respuesta no válida, mostrar mensaje genérico
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text("Error en el servidor"),
                        content: Text("Respuesta no válida del servidor."),
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
                  // El servidor no responde con el código 200
                  /*showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Error en el servidor"),
        content: Text("No se pudo conectar al web service."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );*/
                }
              } catch (e) {
                // Error durante la petición HTTP
                print('Error en la petición HTTP: $e');
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text("Error"),
                    content: Text(
                        "Hubo un error al realizar la petición al servidor."),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("OK"),
                      ),
                    ],
                  ),
                );
              }

              setState(() {
                _data = formattedData;
                widget.updateScannedData(formattedData);
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
