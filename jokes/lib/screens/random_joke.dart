import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jokes/models/joke_model.dart';
import '../models/Category.dart';
import '../services/api_service.dart';
import '../widgets/jokes/back_button.dart';
import '../widgets/jokes/details_joke.dart';

class RandomJoke extends StatefulWidget {
  const RandomJoke({super.key});

  @override
  State<RandomJoke> createState() => _RandomJokeState();
}

class _RandomJokeState extends State<RandomJoke> {
  Joke? joke;

  @override
  void initState() {
    super.initState();
    getRandomJokeFromAPI();
  }

  Color generateColorFromId(int id) {
    int red = (id * 37) % 256; //
    int green = (id * 59) % 256;
    int blue = (id * 83) % 256;

    return Color.fromARGB(255, red, green, blue);
  }

  void getRandomJokeFromAPI() async {
    var color = generateColorFromId(1);
    ApiService.getRandomJokeFromAPI().then((response) {
      var data = json.decode(response.body);
      setState(() {
        joke = Joke(
          id: data['id'],
          setup: data['setup'],
          punchline: data['punchline'],
          type: Category(id: 0, name: data['type'], color: color),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (joke == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: DetailJokeDescription(
                id: joke!.id,
                setup: joke!.setup,
                punchline: joke!.punchline,
                type: joke!.type,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: const DetailBackButton(),
    );
  }
}
