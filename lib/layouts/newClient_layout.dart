// ignore: file_names
import 'package:flutter/material.dart';
import '../widgets/widget.dart';

class NewClientLayout extends StatefulWidget {
  const NewClientLayout({super.key});

  @override
  _NewClientLayoutState createState() => _NewClientLayoutState();
}

class _NewClientLayoutState extends State<NewClientLayout> {
  TextEditingController _celularController = TextEditingController();
  TextEditingController _reciboFormController = TextEditingController();
  String selectedTrabajo = '';
  String _scannedData = ''; // Variable para almacenar la información escaneada

  // Función para actualizar la información escaneada desde el ScannerWidget.
  void updateScannedData(String data) {
    setState(() {
      _scannedData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextSubtitleWidget(
          titleText: '# Ingrese Información del Nuevo Cliente',
        ),
        Divider(height: 5),
        CelInputWidget(celularController: _celularController),
        Divider(height: 5),
        JobTipoWidget(
          onJobSelected: (String) {
            selectedTrabajo = selectedTrabajo.toString();
          },
        ),
        Divider(height: 5),
        ReciboFormWidget(
          reciboFormController: _reciboFormController,
        ),
        Divider(height: 5),
        DataSelectWidget(),
        Divider(height: 5),
        ScannerWidget(
          updateScannedData: updateScannedData,
        ),
        Divider(height: 5),
      ],
    );
  }
}
