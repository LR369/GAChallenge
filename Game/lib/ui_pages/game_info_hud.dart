import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:sustain_game/game_components/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:sustain_game/game_components/custom_sprite.dart';
import 'package:sustain_game/controllers/game_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class GameInfoHUD extends PositionComponent with HasGameRef {
  late TextBoxComponent _gameText;

  late CustomSprite _customSprite;
  late CustomSprite _customSprite2;
  late CustomSprite _customSprite3;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    priority = 10;
    size = game.size;
    _gameText = TextBoxComponent(
        text: 'You are the spirit of the earth! \n'
            'Monitoring the actions on earth, you defend the planet by recognising the actions we can improve.'
            '\nLook at the tiles. \nTap to change the action when necessary. \n'
            'Be careful... if you hit a tile already with a positive earth action it becomes the opposite because '
            'actions leave a mark... \nbut Our individual actions can collectively make a difference!'
            '\nLook below at some of the unsustainable actions, you will monitor, learn some of the possible solutions. \nAre you ready?',
        boxConfig: TextBoxConfig(
          maxWidth: 500,
          timePerChar: 0.05,
          growingBox: true,
          margins: const EdgeInsets.all(8),
        ),
        anchor: Anchor.center,
        position: Vector2(game.size.x / 2, game.size.y / 2.8));
    add(_gameText);

    add(CustomButton(
        position: Vector2(game.size.x - 100, 20),
        text: "Back",
        textSizeX: 40,
        onPressed: () =>
            {GameController.hideInfoState(), FlameAudio.play('click.wav')},
        spriteString: 'idle.png'));

    add(CustomButton(
        position: Vector2(game.size.x - 100, 100),
        text: "Learn More",
        textSizeX: 80,
        onPressed: () => {
              FlameAudio.play('click.wav'),
              launchUrl(
                Uri.parse("https://multiuser-bc138.web.app/learn"),
              )
            },
        spriteString: 'idle.png')
      ..size = Vector2(100, 40));

    _customSprite = CustomSprite(
        name: "info_1.png",
        pos: Vector2(game.size.x / 3, game.size.y - 100),
        sizeX: Vector2(game.size.x / 3, 200));
    add(_customSprite);
    _customSprite2 = CustomSprite(
        name: "info_2.png",
        pos: Vector2(game.size.x / 1.5, game.size.y - 100),
        sizeX: Vector2(game.size.x / 3, 200));
    add(_customSprite2);

    _customSprite3 = CustomSprite(
        name: "gaia_spirit.png",
        pos: Vector2(game.size.x / 12, game.size.y / 3.5),
        sizeX: Vector2(game.size.x / 10, game.size.y / 6));
    add(_customSprite3);
  }
}
