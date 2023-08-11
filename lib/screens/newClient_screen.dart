import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/component.dart';
import '../widgets/widget.dart';
import 'package:mvp_sfh_flutter/providers/provider.dart';

class NewClientScreen extends StatefulWidget {
  final String scannedData;

  const NewClientScreen({Key? key, required this.scannedData});

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

  @override
  Widget build(BuildContext context) {
    final userInfoProvider =
        Provider.of<UserInfoProvider>(context, listen: false);
    ButtonSms buttonSms = ButtonSms();
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
                //print('Fecha seleccionada en MiOtraPantalla: $fechaSeleccionada');
              },
            ),
            const Divider(height: 5),
            TextSubtitleWidget(
              titleText: '# Foto de Perfil y Scanner DNI',
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 15),
                const ImageUsuarioWidget(),
                const SizedBox(width: 15),
                InfoDniWidget(),
              ],
            ),
            const Divider(height: 5),
            TextSubtitleWidget(
              titleText: '# Foto DNI, Recivo de Sueldo, Garante',
            ),
            ImagePeper(),
            SizedBox(height: 10),
            SizedBox(
              //*Botón ENVIAR SMS:
              width: 350,
              child: buttonSms.buttonSms(context, _celularController),
            ),
            SizedBox(height: 10),
            SizedBox(
              //*Botón ENVIAR con un ALERT:
              width: 350,
              child: ButtonSend(userInfoProvider, context)
                  .buttonSend(context), // Cambio aquí
            ),
            SizedBox(height: 10),
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








/*
  //LÓGICA DE ENVÍO DE GUARDADO Y ENVIOS DE DATOS (WEBSERVICE)
  void _sendData(DateTime fechaHora) async {
    final userInfoProvider =
        Provider.of<UserInfoProvider>(context, listen: false);

    //!Ingresar Web Service!!!!!!!!!
    final url = Uri.parse('http://192.168.1.241:8000/api/addcliente');
    final headers = {'Content-Type': 'application/json'};
    //final firmaData = firmaWidget.obtenerFirmaData(); // Obtener los datos de la firma
    final body = {
      'celular': userInfoProvider.userInfo.celular,
      'trabajo':
          selectedTrabajo, // remplaza selectedTrabajo con la variable que contiene el valor seleccionado en tu TrabajoTipoWidget
      'infoDni': userInfoProvider.userInfo.infoDni,
      'foto_usuario': userInfoProvider.userInfo.fotos,
      'fotos_paper': userInfoProvider.userInfo
          .imageUrls, // aquí puedes agregar las rutas de las fotos que hayas tomado en tu app

      'total_recibo': userInfoProvider.userInfo.totalRecibo,
      //'fecha_recibo': fechaReciboController.text,
      'fecha_recibo': userInfoProvider.userInfo.fechaRrecibo,
      //TODO:'firmaData': firmaData,
      //fecha de envío de información:
      'fecha_info': DateTime.now().toString(), // incluye la fecha y hora actual
    };

    print('Enviando datos $body');

    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      // El web service respondió correctamente
      print('Información enviada correctamente');
    } else {
      // El web service respondió con un error
      print('Error al enviar la información');
    }
  }*/
