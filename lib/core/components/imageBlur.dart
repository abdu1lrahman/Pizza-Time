import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Imageblur extends StatelessWidget {
  String text;
  String imagePath;
  Imageblur({
    super.key,
    required this.text,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(1.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                //fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
