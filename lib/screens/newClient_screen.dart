import 'package:flutter/material.dart';

import '../layouts/layout.dart';

class NewClientScreen extends StatelessWidget {
  const NewClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Cliente'),
      ),
      body: Column(
        children: [
          NewClientLayout(),
        ],
      ),
    );
  }
}
