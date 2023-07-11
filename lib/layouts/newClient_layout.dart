import 'package:flutter/material.dart';

class NewClientLayout extends StatelessWidget {
  const NewClientLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text('Ingrese Datos de Cliente'),
        ),
        Divider(height: 5),
      ],
    );
  }
}
