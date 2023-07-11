import 'package:flutter/material.dart';

import '../models/model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Seleccione una opcion...')),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              width: 400,
              height: 500,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: MenuOption(),
            ),
          ],
        ),
      ),
      drawer: Drawer(),
    );
  }
}
