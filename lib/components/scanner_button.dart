import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../widgets/widget.dart';

class ButtonScannerComponent extends StatefulWidget {
  const ButtonScannerComponent({super.key});

  @override
  State<ButtonScannerComponent> createState() => _ButtonScannerComponentState();
}

class _ButtonScannerComponentState extends State<ButtonScannerComponent> {
  bool _isContainerVisible = false;
  String _scannedData = "";

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
          backgroundColor: Colors.pink,
          onPressed: () async {
            String scannedData = await FlutterBarcodeScanner.scanBarcode(
              "#000000",
              "Cancelar",
              true,
              ScanMode.BARCODE,
            );

            if (scannedData != "-1") {
              setState(() {
                _scannedData = scannedData;
                _isContainerVisible = true;
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
