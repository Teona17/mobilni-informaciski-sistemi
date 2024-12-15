import 'package:flutter/material.dart';
import 'package:jokes/models/Category.dart';
import 'package:jokes/widgets/jokes/joke_dard_data.dart';

class JokeCard extends StatelessWidget {
  final int id;
  final String setup;
  final String punchline;
  final Category type;

  const JokeCard(
      {super.key,
      required this.id,
      required this.setup,
      required this.punchline,
      required this.type});

  Color generateColorFromId(int id) {
    int red = (id * 37) % 256; //
    int green = (id * 59) % 256;
    int blue = (id * 83) % 256;

    return Color.fromARGB(255, red, green, blue);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: this.generateColorFromId(id),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        splashColor: Colors.red[50],
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.8),
              width: 2,
            ),
          ),
          child: JokeCardData(setup: setup, punchline: punchline, type: type),
        ),
      ),
    );
  }
}
