import 'package:flutter/material.dart';
import 'package:pizza_time/core/constants/constants.dart';

// ignore: camel_case_types
class deafultButton2 extends StatefulWidget {
  final VoidCallback function;
  final String text;
  const deafultButton2({super.key, required this.function, required this.text});

  @override
  State<deafultButton2> createState() => _deafultButton2State();
}

class _deafultButton2State extends State<deafultButton2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: secondryColor,
        ),
        width: double.infinity,
        height: 50,
        child: MaterialButton(
          onPressed: widget.function,
          child: Text(
            widget.text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
