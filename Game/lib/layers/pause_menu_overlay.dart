import 'package:flutter/material.dart';

class PauseMenuOverlay extends StatelessWidget {
  const PauseMenuOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Container(
            padding: const EdgeInsets.all(10.0),
            height: 250,
            width: 300,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 76, 19, 86),
              borderRadius: BorderRadius.all(
                Radius.circular(28),
              ),
            ),
            child: const Card(
                color: Color.fromARGB(255, 27, 96, 30),
                shadowColor: Colors.white,
                elevation: 10,
                margin: EdgeInsets.all(8),
                child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Paused",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 28),
                            ),
                          )
                        ])))));
  }
}
