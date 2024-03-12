import 'dart:math';

import 'package:ballarium/game/component/background.dart';
import 'package:ballarium/game/component/ball.dart';
import 'package:flame/game.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter/services.dart';
import 'package:shake/shake.dart';

class Stage extends FlameGame {
  final Ball redBall = Ball(const Color(0xFFFF0000).withOpacity(0.5));
  final Ball blueBall = Ball(const Color(0xFF0000FF).withOpacity(0.5));
  final Ball greenBall = Ball(const Color(0xFF00FF00).withOpacity(0.5));
  final Ball yellowBall = Ball(const Color(0xFFFFFF00).withOpacity(0.5));
  final BackGround _backGround = BackGround();
  @override
  Future<void> onLoad() async {
    super.onLoad();

    await add(_backGround);
    await add(redBall);
    await add(blueBall);
    await add(greenBall);
    await add(yellowBall);
    setBall(redBall);
    setBall(blueBall);
    setBall(greenBall);
    setBall(yellowBall);

    ShakeDetector.autoStart(
      onPhoneShake: () {
        ballInitialize(redBall);
        ballInitialize(blueBall);
        ballInitialize(greenBall);
        ballInitialize(yellowBall);
      },
    );
  }

  void setBall(Ball ball) {
    ballInitialize(ball);
    ballAction(ball);
  }

  void ballInitialize(Ball ball) {
    ball.position
      ..x = Random().nextInt(size.x.toInt()).toDouble()
      ..y = Random().nextInt(size.y.toInt()).toDouble();
  }

  void ballAction(Ball ball) {
    double speedX = 1;
    double speedY = 1;
    userAccelerometerEventStream().listen((event) {
      if (ball.position.x < ball.size.x / 8) {
        HapticFeedback.lightImpact();
        speedX *= -0.1;
        ball.position.x = ball.size.x / 8;
      } else if (ball.position.x > size.x - ball.size.x / 2) {
        HapticFeedback.lightImpact();
        speedX *= -0.1;
        ball.position.x = size.x - ball.size.x / 2 - 60;
      } else if (ball.position.y < ball.size.y / 8) {
        HapticFeedback.lightImpact();
        speedY *= -0.1;
        ball.position.y = ball.size.y / 8;
      } else if (ball.position.y > size.y - ball.size.y / 2 - 60) {
        HapticFeedback.lightImpact();
        speedY *= -0.1;
        ball.position.y = size.y - ball.size.y - 60;
      }
      if (event.x == 0) {
        speedX = 1;
      } else if (event.y == 0) {
        speedY = 1;
      }
      if (event.x.abs() < 0.4 || event.y.abs() < 0.4 || event.z.abs() < 0.4) {
        speedX += event.x * 50;
        speedY += event.z * 50;
      }
      ball.position
        ..x += speedX
        ..y += speedY;
    });
  }
}
