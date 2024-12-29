import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jokes/widgets/jokes/jokes_grid.dart';

import '../providers/JokeProvider.dart';

class FavoriteJokesScreen extends StatelessWidget {
  const FavoriteJokesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Jokes from all Categories"),
      ),
      body: Consumer<JokeProvider>(
        builder: (context, jokeProvider, _) {
          final favoriteJokes = jokeProvider.favorites;
          return JokesGrid(jokes: favoriteJokes);
        },
      ),
    );
  }
}
