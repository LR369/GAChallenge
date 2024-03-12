import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:sustain_game/game_components/constants.dart';
import 'package:sustain_game/controllers/game_controller.dart';
import 'package:sustain_game/game_components/game_board_bg.dart';
import 'package:sustain_game/layers/game_progress_layer.dart';
import 'package:sustain_game/ui_pages/game_info_hud.dart';
import 'package:sustain_game/ui_pages/hud.dart';
import 'package:sustain_game/game_components/player.dart';
import 'package:sustain_game/layers/tiles_layer.dart';
import 'package:sustain_game/ui_pages/hud_title.dart';
import 'package:flutter/services.dart';
import 'package:flame_audio/flame_audio.dart';

class GamePage extends FlameGame with HasCollisionDetection, KeyboardEvents {
  TilesLayer tileLayer = TilesLayer();
  HUD hud = HUD();
  HUDTitle hudTitle = HUDTitle();
  Player player = Player();
  GameBoardBG bgBoard = GameBoardBG();
  bool isPlayingSound = false;
  late Timer countdown;
  GameInfoHUD infoHud = GameInfoHUD();
  GameProgressLayer progressUI = GameProgressLayer();
  late Vector2 playAreaSize;

  @override
  Color backgroundColor() => const Color.fromARGB(230, 0, 0, 0);
  @override
  Future<void> onLoad() async {
    super.onLoad();
    await images.loadAll([
      'bgtile.png',
      'tile.png',
      'light_off.png',
      'light_on.png',
      'tap_on.png',
      'tap_off.png',
      'car_pool_A.png',
      'car_pool_B.png',
      'local_food.png',
      'world_food.png',
      "compost.png",
      "single_use.png",
      "3_ways.png",
      "eat_fruit.png",
      "cycling.png",
      "rubbish.png",
      "water_bottle.png",
      "coffee_cups.png",
      "less_meat.png",
      "coffee_takeaway.png",
      "coffee_takeout.png",
      "cooler.png",
      "variety_food.png",
      "plugged_in.png",
      "less_electric.png",
      "Flower_2.png",
      "Flower.png",
      'seed_1.png',
      'seed_2.png',
      "solar_powered_car.png",
      "idle.png",
      "menstrual_cup.png",
      "walking.png",
      "tampons.png",
      "raining.png",
      "storm.png",
      "heatwave.png",
      "snowing.png",
      "heat_1.png",
      "raindrop_1.png",
      "raindrop_2.png",
      "hail.png",
      "snowball.png",
      "heatstorm.png",
    ]);

    world.add(tileLayer);

    world.add(hudTitle);

    camera.viewfinder.visibleGameSize =
        //Vector2(Constants.tileWidth * 14 + 2.5 * 8, 7 * Constants.tileHeight);
        Vector2(Constants.tileWidth * 7 + 2.5 * 8, 7 * Constants.tileHeight);
    camera.viewfinder.position = size / 2;
    Vector2(Constants.tileWidth * 3.5 + 2.0 * 4, 0);
    camera.viewfinder.anchor = Anchor.center;
    // playAreaSize = Vector2(size.x * 1.5, 7 * Constants.tileHeight);
    // final gameMidX = playAreaSize.x / 2;
    // camera.viewfinder.visibleGameSize = playAreaSize;
    // camera.viewfinder.position = size / 2;
    // camera.viewfinder.anchor = Anchor.center;
  }

  void addHud() {
    world.add(hud);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (GameController.isGameRestarted() &&
        !GameController.startOverlayActive &&
        GameController.isNone) {
      GameController.gameStarted = false;
      GameController.resetProgress = true;
      overlays.add('GameStartOverlay');
      GameController.startOverlayActive = true;
      restart();
    }
    if (GameController.gameStarted && GameController.startOverlayActive) {
      overlays.remove('GameStartOverlay');

      GameController.startOverlayActive = false;
      GameController.resetProgress = true;
      addHud();
      addTimer();
      addPlayer();
      addProgressUi();
    }
    if (GameController.gameOver && GameController.isPlaying) {
      overlays.add('GameOverOverlay');
      GameController.gameOverOverlayActive = true;
      GameController.isPlaying = false;
      if (!isPlayingSound) {
        FlameAudio.play('game_over.wav');
        isPlayingSound = true;
      }
    }
    if (!GameController.gameOver) {
      if (GameController.gameOverOverlayActive) {
        overlays.remove('GameOverOverlay');
        GameController.gameOverOverlayActive = false;
      }
    }
    if (GameController.isPlaying) {
      countdown.update(dt);
      if (countdown.limit != GameController.tileSpawnerSpeed) {
        countdown.stop();
        addTimer();
      }
    }
    if (GameController.isShowingInfo &&
        !GameController.isPlaying &&
        GameController.startOverlayActive) {
      overlays.remove('GameStartOverlay');
      world.add(infoHud);

      GameController.noneState();
    }
    if (GameController.isHidingInfo && !GameController.isPlaying) {
      world.remove(infoHud);
      overlays.add('GameStartOverlay');
      GameController.noneState();
    }

    if (!GameController.musicOn) {
      stopMusic();
    }
    if (GameController.musicOn && !GameController.musicIsPlaying) {
      startBgmMusic();
    }

    if (GameController.isShowingAddPointsOverlay && !GameController.isPlaying) {
      overlays.add('GameAddPointsOverlay');
      GameController.noneState();
    }
    if (GameController.isHidingAddPointOverlay && !GameController.gameOver) {
      overlays.remove('GameAddPointsOverlay');
      GameController.noneState();
    }
  }

  void addStartOverlay() {
    overlays.add('GameStartOverlay');
    GameController.startOverlayActive = true;
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;

    final isPKey = keysPressed.contains(LogicalKeyboardKey.keyP);
    final isZKey = keysPressed.contains(LogicalKeyboardKey.keyZ);

    if (isPKey && isKeyDown || isZKey && isKeyDown) {
      if (keysPressed.contains(LogicalKeyboardKey.keyP)) {
        if (GameController.paused) {
          resumeEngine();
          GameController.paused = false;
          overlays.remove('PauseMenuOverlay');
        } else {
          pauseEngine();
          GameController.paused = true;
          overlays.add('PauseMenuOverlay');
        }
      }
      if (keysPressed.contains(LogicalKeyboardKey.keyZ)) {}
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  void addTimer() {
    countdown = Timer(GameController.tileSpawnerSpeed,
        onTick: () => GameController.spawnRow = true, repeat: true);

    countdown.start();
  }

  void addPlayer() {
    world.add(player);
    world.add(bgBoard);
  }

  void restart() {
    world.remove(player);
    world.remove(bgBoard);
    world.remove(hud);
    world.remove(progressUI);

    countdown.stop();
    isPlayingSound = false;
  }

  void startBgmMusic() {
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('bg_music.mp3');
    FlameAudio.bgm.audioPlayer.setVolume(0.3);
    GameController.musicIsPlaying = true;
  }

  void stopMusic() {
    FlameAudio.bgm.stop();
    GameController.musicIsPlaying = false;
  }

  void addProgressUi() {
    world.add(progressUI);
  }

  @override
  void onRemove() {
    FlameAudio.bgm.dispose();
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    // camera.viewfinder.visibleGameSize = Vector2(size.x, size.y);
    // Vector2(Constants.tileWidth * 14 + 2.5 * 8, 7 * Constants.tileHeight);
    // Vector2(Constants.tileWidth * 7 + 2.5 * 8, 7 * Constants.tileHeight);

    // gameRef.y = ((size.y / 2 - (maxSkyLevel - minSkyLevel)) +
    //         random.fromRange(minSkyLevel, maxSkyLevel)) -
    //     absolutePositionOf(absoluteTopLeftPosition).y;
  }
}
