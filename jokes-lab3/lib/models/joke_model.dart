import 'package:jokes/models/Category.dart';

class Joke {
  final int id;
  final String setup;
  final String punchline;
  final Category type;

  Joke({
    required this.id,
    required this.setup,
    required this.punchline,
    required this.type,
  });

  Joke.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        setup = data['setup'],
        punchline = data['punchline'],
        type = data['type'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'setup': setup,
        'punchline': punchline,
        'type': type,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Joke &&
        other.setup == setup &&
        other.punchline == punchline;
  }

  @override
  int get hashCode => setup.hashCode ^ punchline.hashCode;
}