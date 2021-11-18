import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:location/src/pages/pages.dart';
import 'package:location/src/providers/scan_list_provider.dart';
import 'package:location/src/providers/ui_provider.dart';

import 'package:location/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    timeDilation = 2;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: AppBarWidget(
          title: "Historial",
          icon: Icons.delete_forever,
        ),
        backwardsCompatibility: true,
        toolbarHeight: 80,
        titleSpacing: 0,
        brightness: Brightness.dark,
      ),
      body: _HomePageSeleccion(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomScanner(),
      bottomNavigationBar: NavBarHome(),
    );
  }
}

class _HomePageSeleccion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final opcionSelect = uiProvider.optionSelected;

    final scanListProvier =
        Provider.of<ScanListProvier>(context, listen: false);

    switch (opcionSelect) {
      case 0:
        scanListProvier.cargarScansPorTipo('geo');
        return MapasPage();

      case 1:
        scanListProvier.cargarScansPorTipo('http');
        return DireccionesPage();

      default:
        return MapasPage();
    }
  }
}
