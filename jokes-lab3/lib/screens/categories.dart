import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jokes/models/Category.dart';
import 'package:jokes/screens/random_joke.dart';
import '../services/api_service.dart';
import '../widgets/categories/categories_grid.dart';
import 'favourite_jokes.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    getCategoriesFromAPI();
  }

  Color generateColorFromId(int id) {
    int red = (id * 37) % 256;
    int green = (id * 59) % 256;
    int blue = (id * 83) % 256;

    return Color.fromARGB(255, red, green, blue);
  }

  void getCategoriesFromAPI() async {
    ApiService.getJokesCategories().then((response) {
      var data = List<String>.from(json.decode(response.body));
      setState(() {
        categories = data.asMap().entries.map<Category>((entry) {
          int index = entry.key;
          String name = entry.value;
          Color categoryColor = generateColorFromId(index + 1);
          return Category(
            id: index + 1,
            name: name,
            color: categoryColor,
          );
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF9ED99C),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu, color: Colors.white, size: 24),
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
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const FavoriteJokesScreen()),
            ),
            icon: const Icon(Icons.star, color: Colors.yellow),
          ),
        ],
      ),
      body: CategoriesGrid(categories: categories),
    );
  }
}
