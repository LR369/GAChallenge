import "dart:async";
import "package:flame/components.dart";

class CustomSprite extends SpriteComponent with HasGameRef {
  String name;
  Vector2 pos;
  Vector2 sizeX;
  CustomSprite({required this.name, required this.pos, required this.sizeX});
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite(name);
    priority = 10;
    position = pos;
    size = sizeX;
    anchor = Anchor.center;
  }
}
