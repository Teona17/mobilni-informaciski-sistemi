import 'dart:ui';

class Category {
  final int id;
  final String name;
  final Color color;

  Category({required this.id, required this.name, required this.color});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'], name: json['name'], color: json['color']);
  }
}
