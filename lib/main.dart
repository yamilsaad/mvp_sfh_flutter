import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:mvp_sfh_flutter/configs/config.dart';
import 'package:provider/provider.dart';

import 'models/model.dart';
import 'screens/screen.dart';
import 'package:mvp_sfh_flutter/providers/provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserInfoProvider()),
        ChangeNotifierProvider(create: (_) => SendDataProvider()),
      ],
      child: const MyApp(),
    ));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalization _localization = FlutterLocalization.instance;
  final String _scannedData =
      ''; // Variable para almacenar la información escaneada

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
      theme: AppTheme(selectedColor: 4).theme(),
      title: 'Credits App SFH',
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeScreen(),
        'new_client': (context) => NewClientScreen(
              scannedData:
                  _scannedData, // Pasar el valor actual de _scannedData
            ),
      },
    );
  }
}
