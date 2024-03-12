import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'package:flame/events.dart';
import 'package:sustain_game/controllers/game_controller.dart';
import 'package:sustain_game/game_components/custom_sprite.dart';

class CustomButton extends PositionComponent with TapCallbacks, HasGameRef {
  static final Paint _white = Paint()..color = const Color(0xFFFFFFFF);

  static final Paint _grey = Paint()
    ..color = const Color.fromARGB(255, 88, 86, 86);
  String text;
  bool _beenPressed = false;
  double textSizeX;
  String spriteString;
  late CustomSprite spriteImg;

  VoidCallback onPressed;

  CustomButton(
      {Vector2? position,
      required this.text,
      required this.textSizeX,
      required this.onPressed,
      required this.spriteString})
      : super(
            position: position, size: Vector2(100, 40), anchor: Anchor.center);
  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    spriteImg =
        CustomSprite(name: spriteString, pos: size / 2, sizeX: Vector2(50, 50));
    add(spriteImg..priority = 5);

    add(TextComponent(
        priority: 10,
        text: text,
        textRenderer: TextPaint(
            style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold)))
      ..position = size / 2
      ..size = Vector2(textSizeX, 20)
      ..anchor = Anchor.center);
  }

  @override
  void render(Canvas canvas) {
    if (spriteString == 'idle.png') {
      canvas.drawRect(size.toRect(), _beenPressed ? _grey : _white);
    }
  }

  @override
  void onTapUp(_) {
    _beenPressed = false;
  }

  @override
  void onTapDown(_) {
    _beenPressed = true;
    onPressed();
    if (spriteString == 'musicOn.png') {}
    changeImage();
  }

  void changeImage() async {
    spriteImg.sprite = await gameRef
        .loadSprite(GameController.musicOn ? "musicOn.png" : "musicOff.png");
  }

  @override
  void onTapCancel(_) {
    _beenPressed = false;
  }
}
