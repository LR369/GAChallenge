import 'dart:async';
import 'package:flame/components.dart';
import 'package:sustain_game/game_components/constants.dart';
import 'package:sustain_game/game_components/effects.dart';
import 'package:sustain_game/controllers/game_controller.dart';
import 'package:sustain_game/tile_components/tile_row.dart';

class TilesLayer extends PositionComponent with HasGameRef {
  List<TileRow> rows = [];
  @override
  Future<void> onLoad() async {
    super.onLoad();
    position = gameRef.size / 2;
    size = Vector2(Constants.rowWidth, Constants.tileHeight * 8);
    anchor = Anchor.center;
    // add(TileRow());
    // add(SpawnComponent(
    //     factory: (_) => TileRow(),
    //     period: GameController.speed,
    //     within: false,
    //     selfPositioning: true));
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (GameController.spawnRow) {
      GameController.changeLevel();
      var row = TileRow();
      add(row);
      rows.add(row);
      GameController.spawnRow = false;
    }
    if (GameController.newGame) {
      if (rows.isNotEmpty) {
        for (int x = 0; x < rows.length; x++) {
          rows[x].removeFromParent();
        }
      }
      GameController.newGame = false;
    }
    //add flower game effect to tile on clearance
    if (GameController.isGamePlaying) {
      if (GameController.clearedTilePos.isNotEmpty) {
        Vector2 pos = GameController.clearedTilePos.removeAt(0);
        add(GameEffects()..position = pos);
      }
    }
  }
}
