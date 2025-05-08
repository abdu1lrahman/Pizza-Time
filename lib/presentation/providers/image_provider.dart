import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageProvider1 extends ChangeNotifier {
  File? _image = File('assets/icons/google.png');
  String _username = 'user';
  String _email = 'email';

  File? get image => _image;
  String get username => _username;
  String get email => _email;

  Future<bool> loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('user_image');
    if (imagePath != null) {
      _image = File(imagePath);
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      return false;
    }
  }

  Widget getUserAvatar() {
    if (loadImage() != false && image != null) {
      return Image.file(
        image!,
        fit: BoxFit.cover,
        width: 140.0,
        height: 140.0,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.account_circle_outlined);
        },
      );
    }
    return const Icon(Icons.account_circle_outlined);
  }

  void changeUsername(String newUsername) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', newUsername);
    _username = newUsername;
    notifyListeners();
  }

  void changeEmail(String newEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', newEmail);
    _email = newEmail;
    notifyListeners();
  }
}
