import 'package:flutter/material.dart';
import 'package:jokes/models/Category.dart';
import 'package:jokes/widgets/categories/category_card_data.dart';

class CategoryCard extends StatelessWidget {
  final int id;
  final String name;
  final Color color;

  const CategoryCard(
      {super.key, required this.id, required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        splashColor: Colors.red[50],
        onTap: () => {
          Navigator.pushNamed(context, '/jokes',
              arguments: Category(id: id, name: name, color: color))
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.8),
              width: 2,
            ),
          ),
          child: CategoryCardData(name: name),
        ),
      ),
    );
  }
}
