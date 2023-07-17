import 'package:flutter/material.dart';

class ReciboFormWidget extends StatefulWidget {
  final TextEditingController reciboFormController;

  const ReciboFormWidget({super.key, required this.reciboFormController});

  @override
  State<ReciboFormWidget> createState() => _ReciboFormWidgetState();
}

class _ReciboFormWidgetState extends State<ReciboFormWidget> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isformReciboValid = true;

  //El metodo dispose elimina el contenido cuando hay un cambio de estado, por ejemplo cuando se sale de la pantalla.
  @override
  void dispose() {
    widget.reciboFormController.dispose();
    super.dispose();
  }

  String? _validateReciboTotal(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingrese el total neto del recibo';
    }
    if (value.length < 5) {
      return 'El monto total debe tener al menos 5 dígitos';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                controller: widget.reciboFormController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.monetization_on_outlined),
                  labelText: 'Sueldo Bruto en Pesos',
                  border: OutlineInputBorder(),
                  hintText: '000000',
                ),
                validator: _validateReciboTotal,
              ),
              if (!_isformReciboValid)
                Text(
                  'Ingrese un número valido',
                  style: TextStyle(color: Colors.red),
                )
            ],
          )),
    );
  }
}
