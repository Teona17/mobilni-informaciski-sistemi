import 'package:flutter/material.dart';

class ClothesCardData extends StatelessWidget {
  final String image;
  final String name;
  final String description;
  final double price;

  const ClothesCardData(
      {super.key,
      required this.name,
      required this.image,
      required this.description,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Image.network(image,
                fit: BoxFit.contain, alignment: Alignment.bottomRight)),
        const Divider(),
        Text(
          "${name[0].toUpperCase()}${name.substring(1)}",
          style: const TextStyle(fontSize: 18, color: Colors.brown, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
