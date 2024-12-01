import 'package:cloth_shop/models/clothes_model.dart';
import 'package:cloth_shop/widgets/clothes/clothes_grid.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Clothes> clothes = [
    Clothes(
      id: 0,
      name: 'Autumn Brown Sweater',
      img:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRnim0lPhcbDkKEJ_Uf9evbA_OvDYLox_8Aw&s',
      description: '"Soft and warm brown sweater, ideal for layering.',
      price: 34.99,
    ),
    Clothes(
      id: 1,
      name: "Premium Winter Jacket",
      img:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQuVOqqBoGOKqZhGmhy2ijb9Q4J1HFn0VivKg&s',
      description: 'A warm winter jacket perfect for cold weather.',
      price: 59.99,
    ),
    Clothes(
      id: 2,
      name: "Red Summer Dress",
      img:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTvFW3vxZrIj2kdJfjFoG7L6M8y51rUrct3w&s',
      description: 'A stylish red dress for sunny days.',
      price: 59.99,
    ),
    Clothes(
      id: 3,
      name: "Cotton Dress",
      img:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRS-Oe5diZbYjauS3N0z4syJrXelrUrtnVJyg&s',
      description: 'A light and breezy dress for warm weather',
      price: 45.99,
    ),
    Clothes(
      id: 4,
      name: "Classic Brown Sweater",
      img:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnuC-BhpbqKjJr1_KHT0eIDRRR9z2kyyXwIg&s',
      description: 'A cozy brown sweater perfect for chilly days.',
      price: 19.99,
    ),
    Clothes(
      id: 5,
      name: "Thermal Insulated Jacket",
      img:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNdY7300E2LVsHiMaDUqidgl7KXoitr7fQfQ&s',
      description: 'Insulated jacket designed for ultimate warmth.',
      price: 79.99,
    ),
    Clothes(
      id: 6,
      name: "Plush Wool Scar",
      img:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQf-JW6XfwPVhFJqzzOWK9S_H-gGqqPg9mK5A&s',
      description: 'A soft and fluffy scarf to keep you warm in winter.',
      price: 19.99,
    ),
    Clothes(
      id: 7,
      name: "Essential Cotton T-Shirt",
      img:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNTcZuNrJLRTJSnYV8XCwv4h-3BSobJtB8zQ&s',
      description: 'Comfortable and simple t-shirt for casual wear',
      price: 15.99,
    ),
    Clothes(
      id: 8,
      name: "Classic Brown Sweater",
      img:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4aGjKL_tGIBCGBpyud6jeE4VjT6bc8A5rAw&s',
      description: 'A timeless skirt that pairs well with any top',
      price: 19.99,
    ),
    Clothes(
      id: 9,
      name: "Casual Denim Jacket",
      img:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVyM_IukqUHjkSHGh4jkuVkinfmIZyhBeZIA&s',
      description: '"A casual jacket for everyday wear with a stylish look.',
      price: 79.99,
    ),
    Clothes(
      id: 10,
      name: "Scarf",
      img:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThotcV2RDYzF5S9snDewgA77fuf0Hku6223w&s',
      description: 'Warm knitted scarf',
      price: 19.99,
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFCBB799),
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.brown,
              size: 26,
            )),
        title: const Text("211032",
            style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings, color: Colors.brown, size: 24))
        ],
      ),
      body: ClothesGrid(clothes: clothes),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        onPressed: () {},
        tooltip: 'Share',
        child: const Icon(Icons.share_rounded,color: Colors.white,),
      ),
    );
  }
}
