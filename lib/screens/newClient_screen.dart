import 'package:flutter/material.dart';
import '../components/component.dart';
import '../widgets/widget.dart';

class NewClientScreen extends StatefulWidget {
  final String scannedData;

  NewClientScreen({Key? key, required this.scannedData});

  @override
  _NewClientScreenState createState() => _NewClientScreenState();
}

class _NewClientScreenState extends State<NewClientScreen> {
  TextEditingController _celularController = TextEditingController();
  TextEditingController _reciboFormController = TextEditingController();
  String selectedTrabajo = '';
  String _scannedData = ''; // Variable para almacenar la información escaneada
  bool isContainerVisible = false;

  void _sendData() async {
    // Aquí armarías el mapa con la información que deseas enviar al web service
    final body = {
      //'DOMICILIO1': selectedLocalidad,
      //'celular': celularController.text,
      //'infoDni': _scannedData,
      // Otros campos...
    };

    // El código para enviar el mapa al web service...
    // Puedes utilizar la función _sendData que ya has proporcionado y adaptarla aquí.
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
            DataSelectWidget(),
            const Divider(height: 5),
            TextSubtitleWidget(
              titleText: '# Foto de Perfil y Scanner DNI',
            ),
            // Mostrar el contenedor con la información escaneada.
            /*Visibility(
              visible: _scannedData.isNotEmpty,
              child: InfoDniWidget(
                data:
                    _scannedData, // Pasamos la información escaneada al widget InfoDniWidget.
              ),
            ),*/
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
