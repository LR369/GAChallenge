import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:sustain_game/layers/game_add_points_overlay.dart';
import 'package:sustain_game/layers/pause_menu_overlay.dart';
import 'package:sustain_game/pages/game_page.dart';
import 'package:sustain_game/layers/game_start_overlay.dart';
import 'package:sustain_game/layers/gameover_overlay.dart';

class GameWorldPage extends StatefulWidget {
  const GameWorldPage({super.key});

  @override
  State<GameWorldPage> createState() => _GameWorldPageState();
}

class _GameWorldPageState extends State<GameWorldPage> {
  final GamePage game = GamePage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        GameWidget(
          game: game,
          overlayBuilderMap: {
            'GameStartOverlay': (_, game) => const GameStartOverlay(),
            'GameOverOverlay': (_, game) => const GameOverOverlay(),
            'PauseMenuOverlay': (_, game) => const PauseMenuOverlay(),
            'GameAddPointsOverlay': (_, game) => GameAddPointsOverlay(),
          },
          initialActiveOverlays: const ['GameStartOverlay'],
        )
      ]),
    );
  }
}
