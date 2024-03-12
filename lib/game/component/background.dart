import 'package:flame/components.dart';

class BackGround extends SpriteComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('blue.jpg');
    size = sprite?.srcSize ?? Vector2.all(0);
  }
}
