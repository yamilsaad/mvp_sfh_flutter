import 'package:flutter/material.dart';

import '../widgets/widget.dart';

class ButtonScannerComponent extends StatefulWidget {
  const ButtonScannerComponent({super.key});

  @override
  State<ButtonScannerComponent> createState() => _ButtonScannerComponentState();
}

class _ButtonScannerComponentState extends State<ButtonScannerComponent> {
  bool _isContainerVisible = false;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.blue.shade700,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton(
          elevation: 5,
          hoverElevation: 5.0,
          highlightElevation: 12.0,
          backgroundColor: Colors.orange.shade700,
          onPressed: () {
            // Ejecutar alguna acción que debe hacer visible el Container
            setState(() {
              _isContainerVisible = true;
            });
            // Crear instancia de ScannerWidget y usarla como hijo de Visibility
            ScannerWidget scannerWidget = ScannerWidget();
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
