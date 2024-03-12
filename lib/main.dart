import 'package:ballarium/game/stage.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  final game = Stage();
  runApp(
    GameWidget(
      game: game,
    ),
  );
}
