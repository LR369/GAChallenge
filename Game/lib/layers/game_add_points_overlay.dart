import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sustain_game/controllers/game_controller.dart';
import 'package:sustain_game/controllers/wallet_controller.dart';

class GameAddPointsOverlay extends StatelessWidget {
  GameAddPointsOverlay({super.key});
  final WalletController controller = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
          padding: const EdgeInsets.all(10.0),
          height: 450,
          width: 400,
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
                    AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return ScaleTransition(
                              scale: animation, child: child);
                        }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Save ${GameController.score} Points',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 26),
                      ),
                    ),
                    Obx(() => !controller.addedPoints.value
                        ? Column(key: const ValueKey<int>(1), children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Obx(() => TextField(
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      hintText: controller.receipient.value,
                                    ),
                                    onChanged: (text) {
                                      controller.addEmail(text);
                                    },
                                  )),
                            ),
                            Obx(() => controller.showNextBtn.value
                                ? ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              const Color.fromARGB(
                                                  255, 26, 15, 40)),
                                    ),
                                    child: const Text(
                                      "Next",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                      ),
                                    ),
                                    onPressed: () {
                                      controller.checkRequest();

                                      //
                                      //  GameController.gameInfoOverlayActive = false;
                                    },
                                  )
                                : Container()),
                            Obx(() => Container(
                                child: controller.showNextStep.value
                                    ? Obx(
                                        () => Container(
                                            child: controller.hasPass.value
                                                ? ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<
                                                                      Color>(
                                                                  const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      14,
                                                                      90,
                                                                      152)),
                                                    ),
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Image(
                                                          image: AssetImage(
                                                              "images/wallet-button.png")),
                                                    ),
                                                    onPressed: () {
                                                      controller
                                                          .updateWalletPoints();
                                                    },
                                                  )
                                                : Obx(() => !controller
                                                        .hasToken.value
                                                    ? Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Obx(
                                                                () => TextField(
                                                                      decoration:
                                                                          InputDecoration(
                                                                        border:
                                                                            const OutlineInputBorder(),
                                                                        hintText: controller
                                                                            .username
                                                                            .value,
                                                                      ),
                                                                      onChanged:
                                                                          (text) {
                                                                        controller
                                                                            .addUsername(text);
                                                                      },
                                                                    )),
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          ElevatedButton(
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          26,
                                                                          15,
                                                                          40)),
                                                            ),
                                                            child: const Text(
                                                              "Create Pass",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 24,
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              controller
                                                                  .createPass();

                                                              //
                                                              //  GameController.gameInfoOverlayActive = false;
                                                            },
                                                          ),
                                                        ],
                                                      )
                                                    : ElevatedButton(
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty.all<
                                                                      Color>(
                                                                  const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      14,
                                                                      90,
                                                                      152)),
                                                        ),
                                                        child: const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Image(
                                                              image: AssetImage(
                                                                  "images/wallet-button.png")),
                                                        ),
                                                        onPressed: () {
                                                          controller
                                                              .addPassToWalletPoints();
                                                        },
                                                      ))),
                                      )
                                    : Container()))
                          ])
                        : const Text('SUCCESS!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20))),
                    const SizedBox(
                      height: 40,
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
                            GameController.hideAddPointsState();
                            GameController.toMenuState();
                            GameController.gameOver = false;
                            GameController.newGame = true;
                            GameController.resetProgress = true;
                            controller.reset();
                          },
                        ),
                        const SizedBox(width: 10),
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
                            GameController.hideAddPointsState();

                            controller.reset();
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
