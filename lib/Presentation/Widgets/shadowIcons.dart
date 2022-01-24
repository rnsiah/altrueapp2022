import 'dart:ui';

import 'package:flutter/material.dart';

class ShadowIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  ShadowIcon({required this.icon, required this.color, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0.5,
          top: 0.5,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 1.0,
              sigmaY: 1.0,
            ),
            child: Icon(this.icon, color: color.withOpacity(0.7)),
          ),
        ),
        Icon(this.icon, color: color),
      ],
    );
  }
}
