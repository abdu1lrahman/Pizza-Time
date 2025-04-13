import 'package:flutter/material.dart';

class DesktopLogin extends StatefulWidget {
  const DesktopLogin({super.key});

  @override
  State<DesktopLogin> createState() => _DesktopLoginState();
}

class _DesktopLoginState extends State<DesktopLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(width: 430),
          Expanded(
            child: Container(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
