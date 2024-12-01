import 'package:flutter/material.dart';

class DetailBackButton extends StatelessWidget {
  const DetailBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => Navigator.pop(context),
      backgroundColor: Colors.brown,
      tooltip: 'Share',
      label: const Text(
        "Back",
        style: TextStyle(color: Colors.white), // Set text color to black
      ),      icon: const Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,),
    );
  }
}
