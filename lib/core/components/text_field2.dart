import 'package:flutter/material.dart';

class TextField2 extends StatelessWidget {
  final Icon icon;
  final String text;
  final double padding = 12.0;
  final String? userName='', email='', password='';

  const TextField2({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: padding, left: padding, right: padding),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 10),
            Text(text),
          ],
        ),
      ),
    );
  }
}
