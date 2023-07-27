import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../components/component.dart';
import '../widgets/widget.dart';

class NewClientScreen extends StatefulWidget {
  final String scannedData;

  NewClientScreen({Key? key, required this.scannedData});

  @override
  _NewClientScreenState createState() => _NewClientScreenState();
}

class _NewClientScreenState extends State<NewClientScreen> {
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _reciboFormController = TextEditingController();
  String? fechaSeleccionada;
  String selectedTrabajo = '';
  String _scannedData = ''; // Variable para almacenar la información escaneada
  bool isContainerVisible = false;

  //LÓGICA DE ENVÍO DE GUARDADO Y ENVIOS DE DATOS (WEBSERVICE)
  void _sendData(DateTime fechaHora) async {
    //!Ingresar Web Service!!!!!!!!!
    final url =
        Uri.parse('http://192.168.1.102:8080/datasnap/rest/TSFHWebSvr/usuario');
    final headers = {'Content-Type': 'application/json'};
    //final firmaData = firmaWidget.obtenerFirmaData(); // Obtener los datos de la firma
    final body = {
      'celular': _celularController.text,
      'trabajo':
          selectedTrabajo, // remplaza selectedTrabajo con la variable que contiene el valor seleccionado en tu TrabajoTipoWidget
      'infoDni': _scannedData,
      'foto_usuario': [],
      'fotos':
          [], // aquí puedes agregar las rutas de las fotos que hayas tomado en tu app
      'fecha': DateTime.now().toString(), // incluye la fecha y hora actual
      'total_recibo': _reciboFormController.text,
      //'fecha_recibo': fechaReciboController.text,
      //'firmaData': firmaData,
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      // El web service respondió correctamente
      print('Información enviada correctamente');
    } else {
      // El web service respondió con un error
      print('Error al enviar la información');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Cliente'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            TextSubtitleWidget(
              titleText: '# Ingrese Información del Nuevo Cliente',
            ),
            const Divider(height: 5),
            CelInputWidget(celularController: _celularController),
            const Divider(height: 5),
            JobTipoWidget(
              onJobSelected: (String) {
                selectedTrabajo = selectedTrabajo.toString();
              },
            ),
            const Divider(height: 5),
            ReciboFormWidget(
              reciboFormController: _reciboFormController,
            ),
            const Divider(height: 5),
            DataSelectWidget(
              onDateSelected: (String selectedDate) {
                // Actualiza la variable local con el valor seleccionado
                fechaSeleccionada = selectedDate;
                print(
                    'Fecha seleccionada en MiOtraPantalla: $fechaSeleccionada');
              },
            ),
            const Divider(height: 5),
            TextSubtitleWidget(
              titleText: '# Foto de Perfil y Scanner DNI',
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 15),
                ImageUsuarioWidget(),
                SizedBox(width: 15),
                InfoDniWidget(
                  data:
                      _scannedData, // Pasamos la información escaneada al widget InfoDniWidget.
                ),
              ],
            ),
            const Divider(height: 5),
            TextSubtitleWidget(
              titleText: '# Foto DNI, Recivo de Sueldo, Garante',
            ),
            ImagePeper(),
            SizedBox(
              //*Botón ENVIAR con un ALERT:
              width: 350,
              child: ButtonSend().buttonSend(
                  context), //instancia de ButtonSend llamando el metodo buttonSend.
            ),
          ],
        ),
      ),
      // Botón de Scanner en la barra inferior
      bottomNavigationBar: ButtonScannerComponent(
        updateScannedData: (String data) {
          setState(() {
            _scannedData = data;
          });
        },
      ),
    );
  }
}








// Mostrar el contenedor con la información escaneada.
            /*Visibility(
              visible: _scannedData.isNotEmpty,
              child: InfoDniWidget(
                data:
                    _scannedData, // Pasamos la información escaneada al widget InfoDniWidget.
              ),
            ),*/