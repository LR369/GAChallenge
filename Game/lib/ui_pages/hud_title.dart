import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'package:sustain_game/controllers/game_controller.dart';
import 'package:sustain_game/game_components/custom_btn.dart';

class HUDTitle extends PositionComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    super.onLoad();

    add(
      TextComponent(text: 'GAIA', textRenderer: _shaded)
        ..anchor = Anchor.topRight
        ..position = Vector2(game.size.x / 8, game.size.y / 10)
        ..size = Vector2.all(100),
    );
    add(CustomButton(
        position: Vector2(10, game.size.y - 20),
        text: "",
        textSizeX: 0,
        onPressed: () => {GameController.toggleMusic()},
        spriteString: GameController.musicOn ? "musicOn.png" : "musicOff.png")
      ..priority = 10);
  }

  final _shaded = TextPaint(
    style: TextStyle(
      color: BasicPalette.white.color,
      fontSize: 40.0,
      shadows: const [
        Shadow(color: Colors.red, offset: Offset(2, 2), blurRadius: 2),
        Shadow(color: Colors.yellow, offset: Offset(4, 4), blurRadius: 4),
      ],
    ),
  );
}
