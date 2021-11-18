import 'package:flutter/material.dart';
import 'package:location/src/providers/scan_list_provider.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatelessWidget {

  final String title;
  final IconData? icon;

  const AppBarWidget({Key? key, required this.title, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return Stack(children: [
      Container(
        width: double.infinity,
        height: 100,
        child: Stack(
          children: [
            CustomPaint(
              size: Size(double.infinity, 100),
              painter: CustomAppbar(),
            ),
            SafeArea(
              child: Row(
                children: [
                TitleAppBar(title: title),
                 IconAppBar(icon: icon,)
                 ],
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}

class IconAppBar extends StatelessWidget {

  final IconData? icon;

  const IconAppBar({Key? key, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final scanListProvier = Provider.of<ScanListProvier>(context);

      if (this.icon != null) {
          return GestureDetector(
            onTap: () => scanListProvier.borrarTodos(),
            child: Padding(
                padding: EdgeInsets.only(left: 90,  top: 2),
                child: Icon(
                  icon,
                  size: 30,
                  color: Colors.white,
          )),
    );
  }
  return Container();
}
}

class TitleAppBar extends StatelessWidget {

final String title;

  const TitleAppBar({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 5, left: 32),
        child: Text(title,
            style: TextStyle(
                color: Colors.white, fontSize: 45, fontFamily: 'BerkshireSwash')));
  }
}

class CustomAppbar extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..style = PaintingStyle.fill;
    Path path = Path();

    Rect gradietnPath = new Rect.fromCircle(
      center: new Offset(size.width / 4, 0),
      radius: size.width / 1.4,
    );

    Gradient gradient = new LinearGradient(
      colors: <Color>[
        Colors.cyan,
        Colors.blue,
      ],
      stops: [
        0.3,
        1.0,
      ],
    );

    path.lineTo(0, size.height * 0.8);
    path.lineTo(size.width * 0.1, size.height);
    path.lineTo(size.width, size.height * 0.8);
    path.lineTo(size.width, 0);

    canvas.drawShadow(path, Colors.black87, 2, true);
    paint.color = Colors.deepOrange;
    paint.shader = gradient.createShader(gradietnPath);
    paint.strokeWidth = 5;
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
