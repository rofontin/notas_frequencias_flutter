import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:notas_frequencia_flutter/ui/pages/home_page.dart';

void main() {
  runApp(const MaterialApp(
    title: 'API Web - Times',
    home: HomePage(),
    debugShowCheckedModeBanner: false,
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
    ],
    supportedLocales: [Locale('pt', 'BR')],
  ));
}
