import 'package:flutter/material.dart';

class DetailClothesDescription extends StatelessWidget {
  final int id;
  final String name;
  final String description;
  final double price;

  const DetailClothesDescription(
      {super.key,
      required this.id,
      required this.name,
      required this.description,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: Colors.white,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(width: 10),
                Text(
                  "${name[0].toUpperCase()}${name.substring(1)}",
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color:Colors.brown ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "Description: $description",
              style: const TextStyle(fontSize: 16, color: Colors.brown),
            ),
            const SizedBox(height: 4),
            Text(
              "Price: $price \$",
              style: const TextStyle(fontSize: 16, color: Colors.brown,fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
