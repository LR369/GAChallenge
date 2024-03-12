import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:sustain_game/game_components/constants.dart';
import 'package:sustain_game/game_components/custom_sprite.dart';
import 'package:sustain_game/game_components/progress_effects.dart';
import 'package:sustain_game/game_components/progress_layer_animation.dart';
import 'package:sustain_game/game_components/tree.dart';
import 'package:sustain_game/controllers/game_controller.dart';

class GameProgressLayer extends PositionComponent with HasGameRef {
  List<Tree> trees = [];
  List<Tree> selectedTrees = [];
  List<CustomSprite> oceans = [];
  late CustomSprite _ocean_1Sprite;

  List<CustomSprite> lands = [];
  List<CustomSprite> higherEffectsLands = [];

  late CustomSprite _map_1Sprite;
  late CustomSprite _map_2Sprite;
  late CustomSprite _map_3Sprite;
  late CustomSprite _map_4Sprite;
  late CustomSprite _map_5Sprite;
  late CustomSprite _map_6Sprite;
  late CustomSprite _map_7Sprite;
  late CustomSprite _map_8Sprite;
  late CustomSprite _map_9Sprite;
  late CustomSprite _map_10Sprite;
  late CustomSprite _map_11Sprite;
  late CustomSprite _map_12Sprite;
  late CustomSprite _map_13Sprite;
  late CustomSprite _map_14Sprite;
  late CustomSprite _map_15Sprite;
  late CustomSprite _map_16Sprite;
  late CustomSprite _map_17Sprite;
  late CustomSprite _map_18Sprite;
  late CustomSprite _map_19Sprite;
  late CustomSprite _map_20Sprite;
  late CustomSprite _map_21Sprite;
  late CustomSprite _map_22Sprite;
  late CustomSprite _map_23Sprite;
  late CustomSprite _map_24Sprite;
  late CustomSprite _map_25Sprite;

  ProgressLayerAnimation animationBox = ProgressLayerAnimation();
  bool isShowingEffect = false;
  bool showMap = false;
  int s = 0;
  var arr = [
    "raindrop_2.png",
    "hail.png",
    "raindrop_1.png",
    "snowball.png",
    "heat_1.png",
  ];
  bool isSoundLoaded = false;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    anchor = Anchor.center;
    addOceans();
    addMap();
    addWeatherAnimation();
  }

  void addOceans() {
    _ocean_1Sprite = CustomSprite(
        name: "ocean_4.png",
        pos: Vector2(
            Constants.tileWidth + Constants.tileSpace, gameRef.size.y - 200),
        sizeX: Vector2(game.size.x / 3, 200));

    add(_ocean_1Sprite
      ..opacity = 1
      ..priority = -20);
    // _ocean_2Sprite = CustomSprite(
    //     name: "ocean_2.png",
    //     pos: Vector2(Constants.tileWidth * 2 + Constants.tileSpace,
    //         gameRef.size.y - 200),
    //     sizeX: Vector2(game.size.x / 10, 200));
    // add(_ocean_2Sprite
    //   ..opacity = 1
    //   ..priority = -20);
    // _ocean_3Sprite = CustomSprite(
    //     name: "ocean_3.png",
    //     pos: Vector2(Constants.tileWidth * 3 + Constants.tileSpace,
    //         gameRef.size.y - 200),
    //     sizeX: Vector2(game.size.x / 10, 200));
    // add(_ocean_3Sprite
    //   ..opacity = 1
    //   ..priority = -20);

    oceans.addAll([
      _ocean_1Sprite,
    ]);
  }

  void addMap() {
    _map_1Sprite = CustomSprite(
        name: "map_1.png",
        pos: Vector2(Constants.tileWidth + 60 + Constants.tileSpace,
            gameRef.size.y - 160),
        sizeX: Vector2(50, 60));

    add(_map_1Sprite..opacity = 1);

    _map_2Sprite = CustomSprite(
        name: "map_2.png",
        pos: Vector2(Constants.tileWidth - 25 + Constants.tileSpace,
            gameRef.size.y - 220),
        sizeX: Vector2(25, 25));

    add(_map_2Sprite..opacity = 1);

    _map_3Sprite = CustomSprite(
        name: "map_3.png",
        pos: Vector2(Constants.tileWidth - 30 + Constants.tileSpace,
            gameRef.size.y - 150),
        sizeX: Vector2(30, 40));

    add(_map_3Sprite..opacity = 1);

    _map_4Sprite = CustomSprite(
        name: "map_4.png",
        pos: Vector2(Constants.tileWidth + 65 + Constants.tileSpace,
            gameRef.size.y - 230),
        sizeX: Vector2(40, 50));

    add(_map_4Sprite..opacity = 1);

    _map_5Sprite = CustomSprite(
        name: "map_5.png",
        pos: Vector2(Constants.tileWidth * 2.9 + Constants.tileSpace,
            gameRef.size.y - 225),
        sizeX: Vector2(40, 40));

    add(_map_5Sprite..opacity = 1);

    _map_6Sprite = CustomSprite(
        name: "map_6.png",
        pos: Vector2(Constants.tileWidth * 2.3 + Constants.tileSpace,
            gameRef.size.y - 160),
        sizeX: Vector2(30, 30));

    add(_map_6Sprite..opacity = 1);

    _map_7Sprite = CustomSprite(
        name: "map_7.png",
        pos: Vector2(Constants.tileWidth - 45 + Constants.tileSpace,
            gameRef.size.y - 250),
        sizeX: Vector2(30, 40));

    add(_map_7Sprite..opacity = 1);

    _map_8Sprite = CustomSprite(
        name: "map_8.png",
        pos: Vector2(Constants.tileWidth * 3.3 + Constants.tileSpace,
            gameRef.size.y - 160),
        sizeX: Vector2(40, 40));

    add(_map_8Sprite..opacity = 1);

    _map_9Sprite = CustomSprite(
        name: "map_9.png",
        pos: Vector2(Constants.tileWidth * 3.1, gameRef.size.y - 190),
        sizeX: Vector2(30, 30));

    add(_map_9Sprite..opacity = 1);

    _map_10Sprite = CustomSprite(
        name: "map_10.png",
        pos: Vector2(Constants.tileWidth * 2.2 + Constants.tileSpace,
            gameRef.size.y - 190),
        sizeX: Vector2(30, 30));

    add(_map_10Sprite..opacity = 1);

    _map_11Sprite = CustomSprite(
        name: "map_11.png",
        pos: Vector2(Constants.tileWidth * 2.7 + Constants.tileSpace,
            gameRef.size.y - 190),
        sizeX: Vector2(30, 30));

    add(_map_11Sprite..opacity = 1);

    _map_12Sprite = CustomSprite(
        name: "map_12.png",
        pos: Vector2(Constants.tileWidth + 1 + Constants.tileSpace,
            gameRef.size.y - 260),
        sizeX: Vector2(40, 40));

    add(_map_12Sprite..opacity = 1);

    _map_13Sprite = CustomSprite(
        name: "map_13.png",
        pos: Vector2(Constants.tileWidth + 30 + Constants.tileSpace,
            gameRef.size.y - 240),
        sizeX: Vector2(25, 30));

    add(_map_13Sprite..opacity = 1);

    _map_14Sprite = CustomSprite(
        name: "map_14.png",
        pos: Vector2(Constants.tileWidth * 3.4, gameRef.size.y - 210),
        sizeX: Vector2(30, 30));

    add(_map_14Sprite..opacity = 1);
    _map_15Sprite = CustomSprite(
        name: "map_15.png",
        pos: Vector2(Constants.tileWidth * 2.5 + Constants.tileSpace,
            gameRef.size.y - 260),
        sizeX: Vector2(50, 25));

    add(_map_15Sprite..opacity = 1);

    _map_16Sprite = CustomSprite(
        name: "map_16.png",
        pos: Vector2(Constants.tileWidth * 2.85 + Constants.tileSpace,
            gameRef.size.y - 245),
        sizeX: Vector2(25, 25));

    add(_map_16Sprite..opacity = 1);

    _map_17Sprite = CustomSprite(
        name: "map_17.png",
        pos: Vector2(Constants.tileWidth * 2.2 + Constants.tileSpace,
            gameRef.size.y - 235),
        sizeX: Vector2(25, 25));

    add(_map_17Sprite..opacity = 1);

    _map_18Sprite = CustomSprite(
        name: "map_18.png",
        pos: Vector2(Constants.tileWidth * 2.5 + Constants.tileSpace,
            gameRef.size.y - 210),
        sizeX: Vector2(25, 30));

    add(_map_18Sprite..opacity = 1);

    _map_19Sprite = CustomSprite(
        name: "map_19.png",
        pos: Vector2(Constants.tileWidth * 3.4 + Constants.tileSpace,
            gameRef.size.y - 120),
        sizeX: Vector2(30, 30));

    add(_map_19Sprite..opacity = 1);

    _map_20Sprite = CustomSprite(
        name: "map_20.png",
        pos: Vector2(Constants.tileWidth - 50 + Constants.tileSpace,
            gameRef.size.y - 195),
        sizeX: Vector2(20, 20));

    add(_map_20Sprite..opacity = 1);

    _map_21Sprite = CustomSprite(
        name: "map_21.png",
        pos: Vector2(Constants.tileWidth - 10 + Constants.tileSpace,
            gameRef.size.y - 183),
        sizeX: Vector2(20, 20));

    add(_map_21Sprite..opacity = 1);

    _map_22Sprite = CustomSprite(
        name: "map_22.png",
        pos: Vector2(Constants.tileWidth - 30 + Constants.tileSpace,
            gameRef.size.y - 195),
        sizeX: Vector2(20, 20));

    add(_map_22Sprite..opacity = 1);

    _map_23Sprite = CustomSprite(
        name: "map_23.png",
        pos: Vector2(Constants.tileWidth + 3 + Constants.tileSpace,
            gameRef.size.y - 210),
        sizeX: Vector2(20, 20));

    add(_map_23Sprite..opacity = 1);

    _map_24Sprite = CustomSprite(
        name: "map_24.png",
        pos: Vector2(Constants.tileWidth + 10 + Constants.tileSpace,
            gameRef.size.y - 190),
        sizeX: Vector2(20, 20));

    add(_map_24Sprite..opacity = 1);

    _map_25Sprite = CustomSprite(
        name: "map_25.png",
        pos: Vector2(Constants.tileWidth + 10 + Constants.tileSpace,
            gameRef.size.y - 170),
        sizeX: Vector2(20, 20));

    add(_map_25Sprite..opacity = 1);

    lands.addAll([
      _map_3Sprite,
      _map_4Sprite,
      _map_5Sprite,
      _map_7Sprite,
      _map_8Sprite,
      _map_10Sprite,
      _map_13Sprite,
      _map_15Sprite,
      _map_1Sprite,
      _map_2Sprite,
      _map_6Sprite,
      _map_9Sprite,
      _map_11Sprite,
      _map_12Sprite,
      _map_14Sprite,
      _map_16Sprite,
      _map_17Sprite,
      _map_18Sprite,
      _map_19Sprite,
      _map_20Sprite,
      _map_21Sprite,
      _map_22Sprite,
      _map_23Sprite,
      _map_24Sprite,
      _map_25Sprite
    ]);

    higherEffectsLands.addAll([
      _map_1Sprite,
      _map_2Sprite,
      _map_6Sprite,
      _map_9Sprite,
      _map_11Sprite,
      _map_12Sprite,
      _map_14Sprite,
      _map_16Sprite,
      _map_17Sprite,
      _map_18Sprite,
      _map_19Sprite,
      _map_20Sprite,
      _map_21Sprite,
      _map_22Sprite,
      _map_23Sprite,
      _map_24Sprite,
      _map_25Sprite
    ]);
    changeOpacity(higherEffectsLands, 0);
    changeOpacity(lands, 0);
    changeOpacity(oceans, 0);
  }

  void changeOpacity(List arr, double val) {
    for (int x = 0; x < arr.length; x++) {
      arr[x].opacity = val;
    }
  }

  void changePriority(List arr, double val) {
    for (int x = 0; x < arr.length; x++) {
      arr[x].priority = val;
    }
  }

  void addWeatherAnimation() {
    animationBox.position = Vector2(
        Constants.tileWidth + 30 + Constants.tileSpace, gameRef.size.y - 380);
    add(animationBox);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (GameController.resetProgress) {
      changeOpacity(higherEffectsLands, 0);
      changeOpacity(lands, 0);
      changeOpacity(oceans, 0);
      showMap = false;
      GameController.resetProgress = false;
    }

    if (GameController.isGamePlaying && GameController.levelComplete) {
      if (!isSoundLoaded) {
        FlameAudio.play('level_completed.wav');
        isSoundLoaded = true;
      }
      Future.delayed(const Duration(seconds: 5),
          () => {GameController.levelComplete = false, isSoundLoaded = false});
    }
    if (GameController.isGamePlaying && GameController.tileMissed) {
      if (!showMap) {
        changeOpacity(higherEffectsLands, 1);
        changeOpacity(lands, 1);
        changeOpacity(oceans, 1);
        showMap = true;
      }
      GameController.tileMissed = false;
      chooseLandAndEffect();
    }
  }

  void chooseLandAndEffect() {
    if (isShowingEffect) return;
    isShowingEffect = true;
    int randomImgNum = Random().nextInt(arr.length);
    int ran = Random().nextInt(higherEffectsLands.length);
    CustomSprite land = higherEffectsLands[ran];
    land.opacity = 1;
    chooseMapAction();
    animationBox.changeAnimation();
    addProgressEffects(arr[randomImgNum], arr[randomImgNum]);
    land.add(addRedGlowEffect());
    FlameAudio.play('hit_1.mp3');
    final effect = SequenceEffect([
      MoveEffect.by(
        Vector2(0, 0),
        onComplete: () => {animationBox.changeAnimation()},
        EffectController(
          duration: 2,
        ),
      ),
      MoveEffect.by(
        Vector2(0, 0),
        onComplete: () => {worldWeatherEffect()},
        EffectController(
          duration: 2.5,
        ),
      ),
      MoveEffect.by(
        Vector2(0, 0),
        onComplete: () => {land.opacity = 0},
        EffectController(
          duration: 2.5,
        ),
      ),
      MoveEffect.by(
        Vector2(0, 0),
        onComplete: () => {isShowingEffect = false},
        EffectController(
          duration: 2.5,
        ),
      ),
    ]);
    add(effect);

    // animationBox.changeAnimation();
    // Future.delayed(const Duration(seconds: 1),
    //     () => {addProgressEffects(arr[randomImgNum], arr[randomImgNum])});

    // land.add(addRedGlowEffect());
    // FlameAudio.play('hit_1.mp3');
    // Future.delayed(
    //     const Duration(seconds: 4), () => {animationBox.changeAnimation()});
    // showWeatherSequence();
    //Future.delayed(const Duration(seconds: 4), () => {land.opacity = 0});

    // Future.delayed(const Duration(seconds: 5), () => {isShowingEffect = false});
  }

  void addProgressEffects(String name, String name2) {
    add(ProgressEffects(name: name, name2: name2)
      ..position = Vector2(
          Constants.tileWidth + 30 + Constants.tileSpace, gameRef.size.y / 2));
  }

  void chooseMapAction() {
    int rand = Random().nextInt(oceans.length);
    oceans[rand].add(shakeEffect());
  }

  SequenceEffect shakeEffect() {
    final shakeEffect = SequenceEffect([
      MoveEffect.by(
        Vector2(10, 0),
        EffectController(duration: 0.5, reverseDuration: .5, repeatCount: 4),
      ),
    ]);
    return shakeEffect;
  }

  SequenceEffect worldEffect() {
    final effect = SequenceEffect([shakeEffect(), addRedGlowEffect()]);
    return effect;
  }

  ColorEffect addRedGlowEffect() {
    final glow = ColorEffect(
      const Color.fromARGB(255, 112, 10, 3),
      EffectController(duration: 1.5, reverseDuration: .5, repeatCount: 3),
      opacityTo: 0.8,
    );
    return glow;
  }

  void worldWeatherEffect() {
    int randAmount = Random().nextInt(lands.length);

    for (int x = 0; x < randAmount; x++) {
      int ran = Random().nextInt(lands.length);
      Future.delayed(const Duration(milliseconds: 150),
          () => {lands[ran].add(worldEffect())});
    }

    //just land
    //just ocean
    //both
    // int ran = Random().nextInt(3);
    // if (ran == 0) {
    //   // chooseLand();
    // } else if (ran == 1) {
    //   // chooseLand();
    // } else if (ran == 2) {
    //   // chooseLand();
    // }
  }

  showWeatherSequence() {
// final effect = SequenceEffect([
//       MoveEffect.by(
//         Vector2(0, 0), onComplete: () => { animationBox.changeAnimation()},
//         EffectController(duration: 0.5, reverseDuration: .5, repeatCount: 1),
//       ),MoveEffect.by(
//         Vector2(0, 0), onComplete: () => { addProgressEffects(arr[randomImgNum], arr[randomImgNum]},
//         EffectController(duration: 1.5, reverseDuration: .5, repeatCount: 1),
//       ),
//        MoveEffect.by(
//         Vector2(0, 0), onComplete: () => { land.add(addRedGlowEffect())},
//         EffectController(duration: 0.5, reverseDuration: .5, repeatCount: 1),
//       ),
//       MoveEffect.by(
//         Vector2(0, 0), onComplete: () => { FlameAudio.play('hit_1.mp3')},
//         EffectController(duration: 0.5, reverseDuration: .5, repeatCount: 1),
//       ),MoveEffect.by(
//         Vector2(0, 0), onComplete: () => { animationBox.changeAnimation()},
//         EffectController(duration: 0.5, reverseDuration: .5, repeatCount: 1),
//       ),
//       MoveEffect.by(
//         Vector2(0, 0), onComplete: () => { showWeatherSequence()},
//         EffectController(duration: 0.5, reverseDuration: .5, repeatCount: 1),
//       ),
//     ]);

    //    animationBox.changeAnimation();
    // Future.delayed(const Duration(seconds: 1),
    //     () => {addProgressEffects(arr[randomImgNum], arr[randomImgNum])});

    // land.add(addRedGlowEffect());
    // FlameAudio.play('hit_1.mp3');
    // Future.delayed(
    //     const Duration(seconds: 4), () => {animationBox.changeAnimation()});
    // showWeatherSequence();
  }
}
