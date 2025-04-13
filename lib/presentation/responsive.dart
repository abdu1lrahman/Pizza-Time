import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pizza_time/presentation/mobileScreens/desktop_login.dart';
import 'package:pizza_time/presentation/mobileScreens/home_screen.dart';
import 'package:pizza_time/presentation/mobileScreens/login.dart';

class Responsive extends StatefulWidget {
  const Responsive({super.key});

  @override
  State<Responsive> createState() => _ResponsiveState();
}

class _ResponsiveState extends State<Responsive> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late bool userSignedIn;

  Future<void> _checkLoginStatus() async {
    User? user = _auth.currentUser;
    setState(() {
      userSignedIn = (user != null) ? true : false;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return userSignedIn == true ? const HomeScreen() : const Login();
        } else {
          return userSignedIn == true ? const DesktopLogin() : const DesktopLogin();
        }
      },
    );
  }
}

