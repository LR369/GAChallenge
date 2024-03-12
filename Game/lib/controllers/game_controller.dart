import 'package:flame/components.dart';

enum GameState { gameOver, ready, gameStarted, isPlaying }

enum OverlayState { none, showInfo, hideInfo, showAddPoints, hideAddPoints }

class GameController {
  static bool gameOver = true;
  static bool gameStarted = false;
  static bool isPlaying = false;
  static int level = 0;
  static int score = 0;
  static int tilesCleared = 20;
  static int totalTilesCleared = 0;
  static int missedTiles = 0;
  static int speed = 40;
  static double tileSpawnerSpeed = 20;
  static bool spawnRow = false;
  static int rowAmount = 3;
  static int calculateGaiaPoints = 0;
  static int pictureArrLevel = 3;

  static bool startOverlayActive = true;
  static bool gameOverOverlayActive = false;
  static bool gameInfoOverlayActive = false;
  static bool paused = false;

  static bool newGame = false;
  static bool musicOn = false;
  static bool effectsOn = true;
  static bool isEasy = false;
  static GameState gameState = GameState.ready;
  static OverlayState overlayState = OverlayState.none;
  static List<Vector2> clearedTilePos = [];
  static bool levelComplete = false;
  static bool tileMissed = false;
  static bool get isGameOver => gameState == GameState.gameOver;
  static bool get isGamePlaying => gameState == GameState.isPlaying;
  static bool get isGameStateRaady => gameState == GameState.ready;
  static bool get isNone => overlayState == OverlayState.none;
  static bool get isShowingInfo => overlayState == OverlayState.showInfo;
  static bool get isHidingInfo => overlayState == OverlayState.hideInfo;
  static bool get isShowingAddPointsOverlay =>
      overlayState == OverlayState.showAddPoints;
  static bool get isHidingAddPointOverlay =>
      overlayState == OverlayState.hideAddPoints;
  static bool musicIsPlaying = false;
  static bool resetProgress = false;
  static void startGame() {
    gameState = GameState.isPlaying;
    gameOver = false;
    gameStarted = true;
    isPlaying = true;
    overlayState = OverlayState.none;

    reset();
  }

  static void endGame() {
    gameState = GameState.gameOver;
    gameOver = true;
    gameStarted = false;
  }

  static void toMenuState() {
    gameState = GameState.ready;
  }

  static void showInfoState() {
    overlayState = OverlayState.showInfo;
  }

  static void hideInfoState() {
    overlayState = OverlayState.hideInfo;
  }

  static void showAddPointsState() {
    overlayState = OverlayState.showAddPoints;
  }

  static void hideAddPointsState() {
    overlayState = OverlayState.hideAddPoints;
  }

  static void noneState() {
    overlayState = OverlayState.none;
  }

  static bool isGameRestarted() {
    return gameState == GameState.ready ? true : false;
  }

  static void changeIsPlaying() {
    isPlaying = false;
  }

  static void toggleMusic() {
    musicOn = !musicOn;
  }

  static void reset() {
    level = 0;
    score = 0;
    tilesCleared = 20;
    speed = 60;
    tileSpawnerSpeed = 20;
    spawnRow = true;
    rowAmount = 3;
    totalTilesCleared = 0;
    pictureArrLevel = 3;
    missedTiles = 0;
  }

  static void changeLevel() {
    switch (tilesCleared) {
      case 0:
        {
          levelComplete = true;
          level++;

          tileSpawnerSpeed = 15;

          if (rowAmount < 9) {
            rowAmount++;
          }
          if (level < 3) {
            tilesCleared = 20;

            //totalTilesCleared += 20;
            speed = 45;
          } else {
            if (level < 6) {
              speed = 60;
              tilesCleared = 40;
              // totalTilesCleared += 40;
            } else if (level < 8) {
              speed = 80;
              tilesCleared = 60;
              // totalTilesCleared += 60;
            } else if (level < 10) {
              speed = 100;
              tilesCleared = 80;
              //totalTilesCleared += 80;
            } else {
              speed = 100;
              tilesCleared = 100;
              //totalTilesCleared += 100;
            }
          }
        }
      case 5:
        {
          speed += 2;
        }
      case 10:
        {
          speed += 2;
          tileSpawnerSpeed = 5;
        }
      case 15:
        {
          speed += 2;
          tileSpawnerSpeed = 8;
        }
      case 20:
        {
          speed += 2;
          // if (level < 3) {
          tileSpawnerSpeed = 10;
          //  }
        }
      case 25:
        {
          speed += 2;
        }
      case 30:
        {
          speed += 2;
        }
      case 35:
        {
          tileSpawnerSpeed = 15;
          speed += 2;
        }
      case 45:
        {
          tileSpawnerSpeed = 16;
          speed += 2;
        }
      case 55:
        {
          tileSpawnerSpeed = 17;
          speed += 5;
        }
      case 65:
        {
          speed += 5;
        }

      default:
        if (tilesCleared < 0) {}
    }
  }

  static int scoreCalculator() {
    int bonus = 20;
    if (level > 10) {
      bonus = 40;
    }
    score = ((bonus * (level > 0 ? level : 1)) + totalTilesCleared) %
        (missedTiles > 0 ? missedTiles : 2);

    return score;
  }
}
