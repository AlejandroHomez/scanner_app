import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:location/src/providers/scan_list_provider.dart';
import 'package:location/src/utils/utils.dart';
import 'package:provider/provider.dart';

class BottomScanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#ff4848', 'Cancelar', true, ScanMode.QR);

        // String barcodeScanRes = "geo:4.430990,-75.231559";

        if (barcodeScanRes == '-1') {
          return;
        }

        final scanListProvier =
            Provider.of<ScanListProvier>(context, listen: false);

        final nuevoScan = await scanListProvier.nuevoScan(barcodeScanRes);

        launchURL(context, nuevoScan);
      },
      child: Hero(
        tag: 'Float',
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          width: 65,
          height: 65,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 4),
              borderRadius: BorderRadius.circular(50),
              gradient: LinearGradient(colors: [
                Colors.cyan,
                Colors.blue,
              ])),
          child: Icon(
            Icons.qr_code_scanner,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
