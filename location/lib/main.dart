import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:location/src/pages/pages.dart';

import 'package:location/src/providers/scan_list_provider.dart';
import 'package:location/src/providers/ui_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => ScanListProvier())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: 'home',
        routes: {
          'home': (_) => HomePage(),
          'mapa': (_) => MapaPage(),
        },
        theme: ThemeData(primaryColor: Colors.amber),
      ),
    );
  }
}
