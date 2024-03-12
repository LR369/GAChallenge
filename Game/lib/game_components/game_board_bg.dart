import 'package:flame/components.dart';
import 'package:sustain_game/game_components/constants.dart';

class GameBoardBG extends SpriteComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('bgtile.png');
    position = gameRef.size / 2;
    size = Vector2(Constants.rowWidth, Constants.boardHeight);
    anchor = Anchor.center;
  }
}
