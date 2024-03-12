import 'dart:async';
import 'package:flame/components.dart';
import 'package:sustain_game/game_components/constants.dart';
import 'package:sustain_game/controllers/game_controller.dart';
import 'tile.dart';

class TileRow extends PositionComponent with HasGameRef, Notifier {
  var pos = {
    "3": (Constants.tileWidth * 3.5),
    "4": (Constants.tileWidth * 2.7),
    "5": (Constants.tileWidth * 2.2),
    "6": (Constants.tileWidth * 1.8),
    "7": (Constants.tileWidth * 1.5),
    "8": (Constants.tileWidth),
    "9": ((Constants.tileWidth / 2.5)),
  };
  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    anchor = Anchor.center;
    setUpRow();
  }

//set up a row of tiles that drop from top of the screen
  void setUpRow() {
    var tileOffset =
        pos[GameController.rowAmount.toString()] ?? Constants.tileWidth * 2.2;

    for (int x = 0; x < GameController.rowAmount; x++) {
      add(Tile(GameController.speed)
        ..position = Vector2(
            (tileOffset) + x * (Constants.tileWidth + Constants.tileSpace), 0));
    }
  }
}
