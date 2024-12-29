import 'package:flutter/material.dart';
import 'package:jokes/models/joke_model.dart';
import 'package:jokes/widgets/jokes/joke_card.dart';

class JokesGrid extends StatefulWidget {
  final List<Joke> jokes;

  const JokesGrid({super.key, required this.jokes});

  @override
  State<JokesGrid> createState() => _JokesGridState();
}

class _JokesGridState extends State<JokesGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        padding: const EdgeInsets.all(4),
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        semanticChildCount: 250,
        childAspectRatio: 200 / 244,
        shrinkWrap: true,
        children: widget.jokes
            .map((joke) => JokeCard(
                id: joke.id,
                setup: joke.setup,
                punchline: joke.punchline,
                type: joke.type))
            .toList());
  }
}
