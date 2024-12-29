import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jokes/providers/JokeProvider.dart';
import 'package:jokes/screens/favourite_jokes.dart';
import 'package:jokes/services/appNotificationService.dart';
import "package:provider/provider.dart";
import 'package:jokes/screens/categories.dart';
import 'package:jokes/screens/jokes.dart';
import 'package:jokes/screens/random_joke.dart';
import 'firebase_options.dart';
import 'models/Category.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AppNotificationService().initialize();
  // runApp(MyApp());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => JokeProvider(),
      child: MaterialApp(
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
          '/details': (context) => const RandomJoke(),
          '/favorites': (context) => const FavoriteJokesScreen(),
        },
      ),
    );
  }
}
