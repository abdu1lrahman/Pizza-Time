import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageProvider1 extends ChangeNotifier {
  File? _image = File('assets/icons/google.png');
  File? get image => _image;
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
}
