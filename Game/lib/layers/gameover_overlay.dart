import 'package:flutter/material.dart';
import 'package:sustain_game/controllers/game_controller.dart';

class GameOverOverlay extends StatelessWidget {
  const GameOverOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
          padding: const EdgeInsets.all(10.0),
          height: 450,
          width: 425,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(28),
            ),
          ),
          alignment: Alignment.topCenter,
          child: Card(
              color: const Color.fromARGB(255, 67, 12, 118),
              shadowColor: const Color.fromARGB(255, 245, 177, 248),
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
                        'Game Over',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 24),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'You Reached ',
                        style: const TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 236, 249, 255)),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Level ${GameController.level}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white)),
                          const TextSpan(
                            text: ' and contributed to ',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 236, 249, 255)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  ' ${GameController.totalTilesCleared} sustainable actions!',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'You Scored ',
                        style: const TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 236, 249, 255)),
                        children: <TextSpan>[
                          TextSpan(
                            text: '${GameController.scoreCalculator()} ',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                          const TextSpan(
                            text: 'GAIA Spirit Points!',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                      text: const TextSpan(
                        text: 'Save Your ',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 236, 249, 255)),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'GAIA Spirit Points',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 30, 192, 36))),
                          TextSpan(
                              text: ' to Google Wallet?',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 236, 249, 255)))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 15, 110, 18)),
                      ),
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      onPressed: () {
                        //change to bool

                        GameController.showAddPointsState();
                        GameController.gameOver = false;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 15, 110, 18)),
                      ),
                      child: const Text(
                        "Play Again",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      onPressed: () {
                        GameController.resetProgress = true;
                        GameController.newGame = true;
                        GameController.startGame();
                        
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          child: const Text(
                            'Menu',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(174, 255, 255, 255)),
                          ),
                          onPressed: () {
                            GameController.toMenuState();
                            GameController.gameOver = false;
                            GameController.newGame = true;
                            GameController.resetProgress = true;
                          },
                        )
                      ],
                    )
                  ],
                ),
              ))),
    );
  }
}
