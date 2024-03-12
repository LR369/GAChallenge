import 'dart:async';
import 'package:flame/components.dart';
import 'package:sustain_game/game_components/constants.dart';

class TileBG extends SpriteComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    super.onLoad();

    sprite = await gameRef.loadSprite('tile.png');
    priority = -5;

    size = Vector2(Constants.tileWidth, Constants.tileHeight);
    anchor = Anchor.center;
  }
}
