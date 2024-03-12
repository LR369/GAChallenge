import 'dart:async';
import 'package:sustain_game/game_components/constants.dart';
import 'package:flame/components.dart';
import 'dart:math';

enum TileState {
  sustainable,
  unsustainable,
  idleSustainable,
  idleunsustainable
}

class TileFG extends SpriteAnimationGroupComponent with HasGameRef {
  SpriteAnimationGroupComponent<TileState> animationComponent =
      SpriteAnimationGroupComponent<TileState>();
  var imageNamesSustainableArr = [
    "light_off.png",
    "solar_powered_car.png",
    "tap_off.png",
    "local_food.png",
    "compost.png",
    "water_bottle.png",
    "coffee_cups.png",
    "eat_fruit.png",
    "cycling.png",
    "3_ways.png",
    "variety_food.png",
    "coffee_cups.png",
    "cooler.png",
    "less_electric.png",
    "menstrual_cup.png",
    "walking.png"
  ];
  var imageNamesUnsustainableArr = [
    "light_on.png",
    "car_pool_A.png",
    "tap_on.png",
    "world_food.png",
    "rubbish.png",
    "single_use.png",
    "coffee_takeaway.png",
    "less_meat.png",
    "car_pool_A.png",
    "rubbish.png",
    "less_meat.png",
    "coffee_takeaway.png",
    "single_use.png",
    "plugged_in.png",
    "tampons.png",
    "car_pool_A.png",
  ];
  @override
  Future<void> onLoad() async {
    super.onLoad();
    int rand = Random().nextInt(imageNamesSustainableArr.length);
    priority = 5;
    //int rand = 10;

    final unsustainable = SpriteAnimation.fromFrameData(
        game.images.fromCache(imageNamesUnsustainableArr[rand]),
        SpriteAnimationData.sequenced(
          amount: 4,
          textureSize: Vector2(75, 100),
          stepTime: 0.25,
        ));

    final sustainable = SpriteAnimation.fromFrameData(
        game.images.fromCache(imageNamesSustainableArr[rand]),
        SpriteAnimationData.sequenced(
          amount: 4,
          textureSize: Vector2(75, 100),
          stepTime: 0.25,
        ));

    final unsustainableIdle = SpriteAnimation.fromFrameData(
        game.images.fromCache(imageNamesUnsustainableArr[rand]),
        SpriteAnimationData.sequenced(
            amount: 4,
            textureSize: Vector2(75, 100),
            stepTime: 0.25,
            loop: false));

    final sustainableIdle = SpriteAnimation.fromFrameData(
        game.images.fromCache(imageNamesSustainableArr[rand]),
        SpriteAnimationData.sequenced(
            amount: 4,
            textureSize: Vector2(75, 100),
            stepTime: 0.25,
            loop: false));

    animationComponent = SpriteAnimationGroupComponent<TileState>(
      animations: {
        TileState.unsustainable: unsustainable,
        TileState.sustainable: sustainable,
        TileState.idleSustainable: sustainableIdle,
        TileState.idleunsustainable: unsustainableIdle,
      },
      current: chooseTileState(),
      size: Vector2(Constants.tileWidth, Constants.tileHeight - 5),
      position: size / 2,
    );
    add(animationComponent);

    size = Vector2(Constants.tileWidth, Constants.tileHeight);
    anchor = Anchor.center;
  }

  void changeAnimation() {
    if (animationComponent.current == TileState.unsustainable) {
      animationComponent.current = TileState.sustainable;
    } else if (animationComponent.current == TileState.sustainable) {
      animationComponent.current = TileState.unsustainable;
    }
  }

  void setLandedAnimation() {
    if (animationComponent.current == TileState.unsustainable) {
      animationComponent.current = TileState.idleunsustainable;
    } else if (animationComponent.current == TileState.sustainable) {
      animationComponent.current = TileState.idleSustainable;
    }
  }

  bool isStateSustainable() {
    return animationComponent.current == TileState.sustainable ? true : false;
  }

  TileState chooseTileState() {
    int ran = Random().nextInt(2);
    TileState state;
    if (ran == 0) {
      state = TileState.sustainable;
    } else {
      state = TileState.unsustainable;
    }
    return state;
  }
}
