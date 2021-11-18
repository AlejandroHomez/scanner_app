import 'dart:ui';

import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {


  final IconData icon;
  final double size;
  final Gradient? gradient;

  const GradientIcon({Key? key, required this.icon, required this.size, this.gradient}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {

    Gradient gradientFinal;

    if( gradient == null ) {
      
         gradientFinal = LinearGradient(colors: [
              Colors.cyan,
              Colors.blue,
              ]
        );
    } else {
      
      gradientFinal = gradient!;
    }
  
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradientFinal.createShader(rect);
      },
    );
  }
}
