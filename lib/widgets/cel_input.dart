import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/provider.dart';

class CelInputWidget extends StatefulWidget {
  final TextEditingController celularController;

  CelInputWidget({Key? key, required this.celularController});

  @override
  State<CelInputWidget> createState() => _CelInputWidgetState();
}

class _CelInputWidgetState extends State<CelInputWidget> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isPhoneNumberValid = true;

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingrese un número de celular válido';
    }
    if (value.length < 10) {
      return 'El número debe contener al menos 10 dígitos';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final userCelProvider = Provider.of<UserInfoProvider>(context);

    return Container(
      margin: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              controller: widget.celularController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  labelText: 'Número de tel.',
                  border: OutlineInputBorder(),
                  hintText: '02641500000'),
              validator: _validatePhoneNumber,
              onChanged: (value) {
                setState(() {
                  _isPhoneNumberValid = true;
                });
                // Actualizar el campo celular en el modelo UserInfo utilizando el proveedor
                userCelProvider.userInfo.celular = value;
              },
            ),
            if (!_isPhoneNumberValid)
              Text(
                'Ingrese número válido...',
                style: TextStyle(color: Colors.red),
              )
          ],
        ),
      ),
    );
  }
}
