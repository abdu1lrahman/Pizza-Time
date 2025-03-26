import 'package:flutter/material.dart';
import 'package:pizza_time/core/constants/constants.dart';

// ignore: camel_case_types, must_be_immutable
class deafultButton extends StatelessWidget {
  final String name;
  GestureTapCallback function;
  double fontSize, width, height;

  deafultButton({
    super.key,
    required this.name,
    required this.function,
    this.fontSize = 17.0,
    this.width = 112,
    this.height = 55,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: width,
        height: height,
        child: InkWell(
          hoverDuration: const Duration(seconds: 3),
          highlightColor: secondryColor,
          focusColor: secondryColor,
          splashColor: secondryColor,
          borderRadius: BorderRadius.circular(10),
          onTap: function,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/${name.toLowerCase()}.png',
                  width: 32.0,
                ),
                Text(
                  ' $name',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: mainGrey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
