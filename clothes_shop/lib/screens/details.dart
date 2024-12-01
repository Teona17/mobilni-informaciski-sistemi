import 'package:cloth_shop/models/clothes_model.dart';
import 'package:cloth_shop/widgets/details/detail_clothe_description.dart';
import 'package:cloth_shop/widgets/details/detail_back_button.dart';
import 'package:cloth_shop/widgets/details/detail_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Clothes;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 200.0), // Add top margin for the image
              child: DetailImage(image: arguments.img),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0), // Add top margin for the title
              child: DetailClothesDescription(
                id: arguments.id,
                name: arguments.name,
                description: arguments.description,
                price: arguments.price,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: const DetailBackButton(),
    );
  }
}
