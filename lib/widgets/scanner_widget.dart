import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

//!TENGO QUE BUSCAR LA FORMA DE MOSTRAR LO SCANEADO!!!!!!!!!!!!! 19/07/23

class ScannerWidget extends StatefulWidget {
  final Function(String) updateScannedData;
  final Key? key;

  const ScannerWidget({this.key, required this.updateScannedData})
      : super(key: key);

  @override
  State<ScannerWidget> createState() => _ScannerWidgetState();
}

class _ScannerWidgetState extends State<ScannerWidget> {
  bool _isContainerVisible = false;
  String dataScan = "";

  void _handleScan(String scannedData) {
    setState(() {
      dataScan = scannedData;
      _isContainerVisible = true;
    });
    // Aquí enviamos la información escaneada hacia arriba usando la función del widget padre.
    widget.updateScannedData(scannedData);
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _isContainerVisible,
      child: InfoDniWidget(
        data: dataScan,
      ), // Pasamos la información escaneada al InfoDniWidget.
    );
  }
}

class InfoDniWidget extends StatelessWidget {
  final String data;
  final Key? key;

  InfoDniWidget({this.key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: double.infinity,
          height: 250,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.pink.shade500,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child:
                Text(data, style: TextStyle(color: Colors.white, fontSize: 25)),
          ),
        ),
      ),
    );
  }
}
