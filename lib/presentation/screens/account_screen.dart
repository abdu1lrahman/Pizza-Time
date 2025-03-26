import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pizza_time/core/components/text_field2.dart';
import 'package:pizza_time/core/constants/constants.dart';
import 'package:pizza_time/generated/l10n.dart';
import 'package:pizza_time/presentation/providers/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  File? _image;
  String? username, email;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> pickImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        prefs.setString('user_image', pickedFile.path);
      });
    }
  }

  Future<void> _loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('user_image');
    if (imagePath != null) {
      setState(() {
        _image = File(imagePath);
      });
    }
    username = prefs.getString('username');
    email = prefs.getString('email');
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondryColor,
        centerTitle: true,
        title: Text(
          S.of(context).my_account,
        ),
        leading: IconButton(
          tooltip: S.of(context).back,
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              'home',
              (route) => false,
            );
          },
          icon: const Icon(Icons.keyboard_backspace),
        ),
        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(S.of(context).Logout),
                  content: Text(S.of(context).Logout_confirm),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        // ignore: unused_local_variable
                        final credential =
                            await FirebaseAuth.instance.signOut();
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.setBool('user_login', false);
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'login', (route) => false);
                      },
                      child: Text(S.of(context).Yes),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(S.of(context).No),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            width: double.infinity,
            color: secondryColor,
            child: Column(
              children: [
                InkWell(
                  onTap: pickImage,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 70.0,
                    child: _image != null
                        ? ClipOval(
                            child: Image.file(
                              _image!,
                              fit: BoxFit.cover,
                              width: 140.0,
                              height: 140.0,
                            ),
                          )
                        : const Icon(
                            color: Colors.black,
                            Icons.add_a_photo_outlined,
                            size: 35,
                          ),
                  ),
                ),
                if (_image != null)
                  TextButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('user_image', '');
                      setState(() {
                        _image = null;
                      });
                    },
                    child: const Text(
                      'remove image',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                TextField2(
                  icon: const Icon(Icons.person_outline),
                  text: 'username',
                ),
                TextField2(
                  icon: const Icon(Icons.email_outlined),
                  text: 'email',
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.black,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(S.of(context).change_language),
              content: Text(S.of(context).change_language_confirm),
              actions: [
                TextButton(
                  onPressed: () async {
                    languageProvider.changeLanguage(
                      Locale(languageProvider.locale.languageCode),
                    );
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                          content: Text(S.of(context).change_language_success)),
                    );
                  },
                  child: Text(S.of(context).Yes),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(S.of(context).No),
                ),
              ],
            ),
          );
        },
        child: const Icon(
          Icons.language_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
