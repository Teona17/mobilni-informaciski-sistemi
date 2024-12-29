import 'package:flutter/material.dart';
import 'package:jokes/models/joke_model.dart';

class JokeProvider with ChangeNotifier {
  List<Joke> _favorites = [];

  List<Joke> get favorites => _favorites;

  void toggleFavoriteJokes(Joke joke) {
    if (_favorites.contains(joke)) {
      _favorites.remove(joke);
    } else {
      _favorites.add(joke);
    }
    notifyListeners();
  }
}
