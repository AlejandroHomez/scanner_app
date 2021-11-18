import 'package:flutter/cupertino.dart';
import 'package:location/src/models/scan_models.dart';
import 'package:location/src/pages/Mapas_Page.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL(BuildContext context, ScanModels scan) async {
  final url = scan.valor;

  if (scan.tipo == 'http') {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  } else {
   Navigator.pushNamed(context, 'mapa' , arguments: scan);
  }
}
