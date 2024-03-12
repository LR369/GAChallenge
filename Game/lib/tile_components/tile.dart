import 'dart:async';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:sustain_game/controllers/game_controller.dart';
import 'package:sustain_game/game_components/player.dart';
import 'package:sustain_game/tile_components/tile_bg.dart';
import 'package:sustain_game/tile_components/tile_fg.dart';
import 'package:sustain_game/game_components/constants.dart';

enum TileState { ready, sustainable, unsustainable }

class Tile extends PositionComponent
    with TapCallbacks, HasGameRef, CollisionCallbacks {
  //define intial state of tile
  Tile(this.speed);

  bool isPressed = false;
  bool landed = false;
  bool canMove = true;
  bool canTap = true;
  bool cleared = false;

  TileFG fg = TileFG();
  TileBG bg = TileBG();
  TileState state = TileState.ready;
  int speed;
  late RectangleHitbox hitBox;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Constants.tileSize;
    bg.position = size / 2;
    add(bg);
    fg.position = size / 2;

    add(fg);
    hitBox = RectangleHitbox(
        size: Constants.tileHitSize, position: size / 2, anchor: Anchor.center);
    add(hitBox);
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (GameController.gameOver) return;
    isPressed = true;

    if (!canTap) return;
    changeStateOfTileFG();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (canMove) {
      position.y += dt * speed;
    }

    if (isPressed) changeStateOfTileFG();

    if (landed && !fg.isStateSustainable()) {
      if (cleared) return;

      cleared = true;
      Future.delayed(const Duration(milliseconds: 200), () {
        canMove = false;
      });

      canTap = false;
      fg.setLandedAnimation();
      GameController.missedTiles++;
      GameController.tileMissed = true;

      Future.delayed(const Duration(milliseconds: 50), () {
        GameController.tileMissed = false;
      });
    }
    if (position.y <= 15 && landed == true) {
      if (!GameController.isGameOver) {
        GameController.endGame();
      }
    }
    if (landed && fg.isStateSustainable()) {
      hitBox.collisionType = CollisionType.inactive;

      if (GameController.tilesCleared > 0) {
        if (cleared) return;
        cleared = true;
        if (!GameController.levelComplete) {
          GameController.tilesCleared--;
          GameController.totalTilesCleared++;
        }
        FlameAudio.play('clear.wav');

        GameController.clearedTilePos.add(position);
      }

      add(effect);
      Future.delayed(const Duration(seconds: 1), () {
        removeFromParent();
      });
    }
  }

  @override
  void onTapUp(TapUpEvent event) => isPressed = false;
  @override
  void onTapCancel(TapCancelEvent event) => isPressed = false;

  void changeStateOfTileFG() {
    fg.changeAnimation();
    FlameAudio.play('tap.ogg');
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Player) {
      landed = true;
      // stop moving
      if (!fg.isStateSustainable()) {
        other.add(addGlowEffect(Colors.yellow, 0.8));
        bg.add(addGlowEffect(Colors.red, 0.5));
        FlameAudio.play('hit_2.mp3');
      }
      if (fg.isStateSustainable()) {
        bg.add(addGlowEffect(Colors.green.shade900, 0.8));
      }
    }
    if (other is Tile) {
      landed = true;

      if (!fg.isStateSustainable() && other.cleared) {
        if (!cleared) {
          bg.add(addGlowEffect(Colors.red, 0.8));
          other.bg.add(addGlowEffect(Colors.yellow, 0.8));
          FlameAudio.play('hit_2.mp3');
        }
      }
      if (fg.isStateSustainable() && other.cleared) {
        bg.add(addGlowEffect(Colors.green.shade900, 0.8));
      }
    }
  }

  ColorEffect addGlowEffect(Color colour, double opacity) {
    final glow = ColorEffect(colour,
        EffectController(duration: 1, reverseDuration: .5, repeatCount: 3),
        opacityTo: opacity);
    return glow;
  }

  final effect = SequenceEffect([
    ScaleEffect.by(
      Vector2.all(1.5),
      EffectController(
        duration: 0.2,
        alternate: false,
      ),
    ),
    ScaleEffect.by(
      Vector2.all(-0.01),
      EffectController(
        duration: 0.2,
        alternate: false,
      ),
    ),
    RemoveEffect(delay: 4)
  ]);
}
