import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<http.Response> getRandomJokeFromAPI() async {
    var response = await http
        .get(Uri.parse('https://official-joke-api.appspot.com/random_joke'));
    print("Response: ${response.body}");
    return response;
  }

  static Future<http.Response> getJokesCategories() async {
    var response = await http
        .get(Uri.parse("https://official-joke-api.appspot.com/types"));
    print("Response: ${response.body}");
    return response;
  }

  static Future<List<Map<String, dynamic>>> getJokesForCategory(
      String type) async {
    final response = await http.get(
        Uri.parse("https://official-joke-api.appspot.com/jokes/$type/ten"));
    if (response.statusCode == 200) {
      print("Success: ${response.body}");
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load data!");
    }
  }
}
