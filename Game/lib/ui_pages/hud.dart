import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/widgets.dart';
import 'package:sustain_game/controllers/game_controller.dart';
import 'package:flutter/material.dart';

class HUD extends PositionComponent with HasGameRef {
  late TextComponent _levelTextTitle;
  late TextComponent _levelText;
  late TextComponent _tilesLeftText;
  late TextComponent _tilesLeftTextTitle;
  late SpriteButton musicControl;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    _levelTextTitle = TextComponent(
      text: 'Level :',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 32,
          color: Colors.white,
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(game.size.x - game.size.x / 8.5, game.size.y / 8),
    );
    add(_levelTextTitle);

    _levelText = TextComponent(
      text: '${GameController.level}',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 32,
          color: Colors.white,
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(game.size.x - game.size.x / 8, game.size.y / 5),
    );
    add(_levelText);

    _tilesLeftTextTitle = TextComponent(
      text: 'Tiles Left :',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 32,
          color: Colors.white,
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(game.size.x - game.size.x / 8, game.size.y / 3),
    );
    add(_tilesLeftTextTitle);

    _tilesLeftText = TextComponent(
      text: '${GameController.tilesCleared}',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 32,
          color: Colors.white,
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(game.size.x - game.size.x / 8, game.size.y / 2.5),
    );
    add(_tilesLeftText);

    //   SpriteButton(
    //   height: 30,
    //   width: 30,
    //   srcPosition: Vector2(10, game.size.y - 50),
    //   sprite: await gameRef
    //       .loadSprite(GameController.musicOn ? "musicOn.png" : "musicOff.png"),
    //   pressedSprite: await gameRef
    //       .loadSprite(GameController.musicOn ? "musicOn.png" : "musicOff.png"),
    //   label: const Text(
    //     '',
    //   ),
    //   onPressed: () => {GameController.toggleMusic()},
    // ));
    // ElevatedButton(
    //   child: Image(
    //       image: GameController.musicOn
    //           ? const AssetImage("musicOn")
    //           : const AssetImage("musicOff")),
    //   onPressed: () => {GameController.toggleMusic()},
    // );
  }

  @override
  void update(double dt) {
    super.update(dt);
    _levelText.text = '${GameController.level}';

    _tilesLeftText.text = '${GameController.tilesCleared}';
  }
}
