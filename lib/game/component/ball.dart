import 'dart:ui';

import 'package:flame/components.dart';

class Ball extends CircleComponent {
  Ball(Color color) {
    radius = 60;
    paint = Paint()..color = color;
  }
}
