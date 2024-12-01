import 'package:cloth_shop/models/clothes_model.dart';
import 'package:cloth_shop/widgets/clothes/clothes_card_data.dart';
import 'package:flutter/material.dart';

class ClothesCard extends StatelessWidget {
  final int id;
  final String name;
  final String image;
  final String description;
  final double price;

  const ClothesCard(
      {super.key,
      required this.id,
      required this.name,
      required this.image,
      required this.description,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        enableFeedback: true,
        splashColor: Colors.yellow[50],
        onTap: () => {
          Navigator.pushNamed(context, "/details",
              arguments: Clothes(
                  id: id,
                  name: name,
                  img: image,
                  description: description,
                  price: price))
        },
        child: Container(
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFCBB799).withOpacity(0.9), width: 3),
              borderRadius: BorderRadius.circular(10)),
          child: ClothesCardData(
            image: image,
            name: name,
            description: description,
            price: price,
          ),
        ),
      ),
    );
  }
}
