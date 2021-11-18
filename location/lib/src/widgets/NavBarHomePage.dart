import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/scheduler.dart';
import 'package:location/src/providers/ui_provider.dart';
import 'package:location/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class NavBarHome extends StatefulWidget {
  @override
  _NavBarHomeState createState() => _NavBarHomeState();
}

class _NavBarHomeState extends State<NavBarHome> {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    final opcionSelect = uiProvider.optionSelected;

    return CurvedNavigationBar(
        onTap: (int i) => uiProvider.optionSelected = i,
        index: opcionSelect,
        animationCurve: Curves.easeIn,
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: Colors.transparent,
        height: 60,
        buttonBackgroundColor: Color.fromRGBO(235, 235, 235, 1),
        color: Color.fromRGBO(235, 235, 235, 1),
        items: [
  
          GradientIcon(icon: Icons.map_sharp, size: 30,),
          GradientIcon(icon: Icons.language, size: 30),

        ]);
  }
}
