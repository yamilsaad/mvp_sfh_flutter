import 'package:flutter/material.dart';

import '../widgets/widget.dart';

class NewClientLayout extends StatelessWidget {
  const NewClientLayout({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _celularController = TextEditingController();
    return Column(
      children: [
        TextSubtitleWidget(
          titleText: '# Ingrese Información del Nuevo Cliente',
        ),
        Divider(height: 5),
        CelInputWidget(celularController: _celularController),
      ],
    );
  }
}
