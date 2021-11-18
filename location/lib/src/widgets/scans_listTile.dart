import 'package:flutter/material.dart';
import 'package:location/src/providers/scan_list_provider.dart';
import 'package:location/src/utils/utils.dart';
import 'package:location/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ScansTile extends StatelessWidget {
  final String tipo;

  const ScansTile({Key? key, required this.tipo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvier>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
        itemCount: scans.length,
        itemBuilder: (_, i) => Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.startToEnd,
              background: EliminarItem(),
              onDismissed: (DismissDirection direction) {
                Provider.of<ScanListProvier>(context, listen: false)
                    .borraScanById(scans[i].id!);
              },
              child: ListTile(
                leading: GradientIcon(

                 icon: this.tipo == 'http' ? Icons.language_outlined : Icons.map,
                    size: 30 ),

                title: Text(scans[i].valor),
                subtitle: Text(scans[i].id.toString()),
                trailing: Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: Colors.deepOrangeAccent,
                ),
                onTap: () => launchURL(context, scans[i]),
              ),
            ));
  }
}

class EliminarItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.redAccent,
        // Colors.red,
        Colors.pink
      ])),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.delete_rounded,
            size: 35,
            color: Colors.white,
          ),
          SizedBox(
            width: 20,
          ),
          Text("Eliminar item",
              style: TextStyle(
                  color: Colors.white, fontFamily: 'BerkshireSwash', fontSize: 25)),
        ],
      ),
    );
  }
}
