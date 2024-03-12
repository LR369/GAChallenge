import 'package:flame/game.dart';

class Constants {
  static const double tileWidth = 75;
  static const double tileHeight = 100;
  static final Vector2 tileSize = Vector2(tileWidth, tileHeight);
  static const double rowWidth = tileWidth * 10;
  static const double boardHeight = tileHeight * 8;
  static final Vector2 tileImageSize = Vector2(tileWidth - 10, tileHeight - 10);
  static const double tileSpace = 2;
  static final Vector2 tileHitSize = Vector2(tileWidth, tileHeight);
}
