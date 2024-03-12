import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:sustain_game/controllers/game_controller.dart';

class GameStartOverlay extends StatelessWidget {
  const GameStartOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: 250,
          width: 300,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(
              Radius.circular(28),
            ),
          ),
          child: Card(
              color: const Color.fromARGB(255, 14, 90, 152),
              shadowColor: const Color.fromARGB(255, 91, 175, 227),
              elevation: 10,
              margin: const EdgeInsets.all(8),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'How To Play',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 26),
                          ),
                        ),
                        const Text(
                            '* Monitor the actions on the tiles \n*Tap to change the tiles to make the action sustainable. ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              child: const Text(
                                'More...',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                GameController.showInfoState();
                                FlameAudio.play('click.wav');
                              },
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 15, 110, 18)),
                          ),
                          child: const Text(
                            "PLAY",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          onPressed: () {
                            GameController.startGame();
                            FlameAudio.play('click.wav');
                          },
                        ),
                      ]))),
        ));
  }
}
//becasue we care some rewards are greater than money
//You are the spirit of the earth \n Press P to pause.
//monitoring the actions and helping to cahnge by recognising actions we can improve
//look at the tiles tapping them to improve the action when necessary be careful if you hit
//a tile already with a positive earth action it becomes the opposite
//the feeeling that one person can't make a difference i s the greatest obstacle o f all.
//Our Actions leave a mark,It doesnt have to be this way if we stop think and do better together