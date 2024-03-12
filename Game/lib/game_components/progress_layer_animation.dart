import 'dart:async';
import 'package:sustain_game/game_components/constants.dart';
import 'package:flame/components.dart';
import 'dart:math';

enum ProgressState {
  weatherEvent,

  weatherEventIdle
}

class ProgressLayerAnimation extends SpriteAnimationGroupComponent
    with HasGameRef {
  SpriteAnimationGroupComponent<ProgressState> animationComponent =
      SpriteAnimationGroupComponent<ProgressState>();
  var arr = [
    "raining.png",
    "storm.png",
    "heatwave.png",
    "snowing.png",
    "heatstorm.png",
  ];

  @override
  Future<void> onLoad() async {
    super.onLoad();
    int rand = Random().nextInt(arr.length);
    // int rand = 4;
    priority = 5;
    opacity = 1;

    final weatherEvent = SpriteAnimation.fromFrameData(
        game.images.fromCache(arr[rand]),
        SpriteAnimationData.sequenced(
            amount: 4,
            textureSize: Vector2(200, 200),
            stepTime: 0.25,
            loop: true));

    final weatherEventIdle = SpriteAnimation.fromFrameData(
        game.images.fromCache("idle.png"),
        SpriteAnimationData.sequenced(
            amount: 1,
            textureSize: Vector2(200, 200),
            stepTime: 0.25,
            loop: false));

    animationComponent = SpriteAnimationGroupComponent<ProgressState>(
      animations: {
        ProgressState.weatherEvent: weatherEvent,
        ProgressState.weatherEventIdle: weatherEventIdle
      },
      current: ProgressState.weatherEventIdle,
      size: Vector2(Constants.tileWidth * 2.5, Constants.tileHeight - 5),
      position: size / 2,
    );
    add(animationComponent);

    size = Vector2(Constants.tileWidth, Constants.tileHeight);
    anchor = Anchor.center;
  }

  void changeAnimation() {
    if (animationComponent.current == ProgressState.weatherEventIdle) {
      animationComponent.current = ProgressState.weatherEvent;
    } else if (animationComponent.current == ProgressState.weatherEvent) {
      animationComponent.current = ProgressState.weatherEventIdle;
    }
  }
}
