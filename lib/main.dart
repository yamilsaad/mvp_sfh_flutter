import 'package:flutter/material.dart';

import 'screens/screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Credits App SFH',
      initialRoute: '/home',
      routes: {
        //'/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        'new_client': (context) => NewClientScreen(),
      },
    );
  }
}
