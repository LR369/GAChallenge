import "dart:async";
import "package:flame/collisions.dart";
import "package:flame/components.dart";
import 'package:sustain_game/game_components/constants.dart';

class Player extends SpriteComponent with HasGameRef, CollisionCallbacks {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('world.png');
    priority = -10;
    position = Vector2(gameRef.size.x / 2, gameRef.size.y + 50);
    size = Vector2(Constants.rowWidth, gameRef.size.y / 4);
    anchor = Anchor.center;
    final hitBox = CircleHitbox(
        radius: size.x / 2,
        isSolid: true,
        collisionType: CollisionType.passive);
    addAll([hitBox]);
  }
}
