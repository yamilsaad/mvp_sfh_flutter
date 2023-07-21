import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import 'models/model.dart';
import 'screens/screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalization _localization = FlutterLocalization.instance;
  String _scannedData = ''; // Variable para almacenar la información escaneada

  @override
  void initState() {
    _localization.init(
      mapLocales: [
        const MapLocale(
          'en',
          AppLocale.EN,
          countryCode: 'US',
          fontFamily: 'Font EN',
        ),
        const MapLocale(
          'es',
          AppLocale.ES,
          countryCode: 'ES',
          fontFamily: 'Font ES',
        ),
      ],
      initLanguageCode: 'en',
    );
    _localization.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
  }

  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: _localization.supportedLocales,
      localizationsDelegates: _localization.localizationsDelegates,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      title: 'Credits App SFH',
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(),
        'new_client': (context) => NewClientScreen(
              scannedData:
                  _scannedData, // Pasar el valor actual de _scannedData
            ),
      },
    );
  }
}
