import 'package:flutter/material.dart';
import 'package:jokes/models/Category.dart';
import 'package:jokes/screens/jokes.dart';
import 'package:jokes/screens/random_joke.dart';

import 'screens/categories.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '211032',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const Categories(),
        '/jokes': (context) {
          final category =
              ModalRoute.of(context)!.settings.arguments as Category;
          return Jokes(category: category);
        },
        '/details': (context) => const RandomJoke()
      },
    );
  }
}
