import 'package:flutter/material.dart';
import 'package:jokes/models/joke_model.dart';
import 'package:jokes/screens/random_joke.dart';
import 'package:jokes/widgets/jokes/jokes_grid.dart';
import '../models/Category.dart';
import '../services/api_service.dart';

class Jokes extends StatefulWidget {
  final Category category;

  const Jokes({super.key, required this.category});

  @override
  State<Jokes> createState() => _JokesScreenState();
}

class _JokesScreenState extends State<Jokes> {
  List<Joke> jokes = [];

  @override
  void initState() {
    super.initState();
    fetchJokesForCategory();
  }

  void fetchJokesForCategory() async {
    ApiService.getJokesForCategory(widget.category.name).then((response) {
      setState(() {
        jokes = response.map<Joke>((jokeData) {
          jokeData['type'] = widget.category;
          return Joke.fromJson(jokeData);
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9ED99C),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
        ),
        title: const Text(
          "211032",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RandomJoke()),
            ),
            child: const Text(
              "Random Joke",
              style: TextStyle(
                backgroundColor: const Color(0xFF328A84),
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings, color: Colors.white, size: 24),
          ),
        ],
      ),
      body: JokesGrid(jokes: jokes),
    );
  }
}
