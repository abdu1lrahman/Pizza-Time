import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pizza_time/core/components/text_field2.dart';
import 'package:pizza_time/core/constants/constants.dart';
import 'package:pizza_time/generated/l10n.dart';
import 'package:pizza_time/presentation/providers/image_provider.dart';
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
  TextEditingController usernameController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    final imageProvider = Provider.of<ImageProvider1>(context, listen: true);
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
                  title: Text(S.of(context).logout),
                  content: Text(S.of(context).logout_confirm),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        // ignore: unused_local_variable
                        final credential =
                            await FirebaseAuth.instance.signOut();
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.setString('user_image', '');
                        Navigator.pushNamedAndRemoveUntil(
                            // ignore: use_build_context_synchronously
                            context,
                            'login',
                            (route) => false);
                      },
                      child: Text(S.of(context).yes),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(S.of(context).no),
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
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  secondryColor,
                  const Color.fromARGB(255, 255, 235, 190)
                ],
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
            width: double.infinity,
            child: Column(
              children: [
                InkWell(
                  onTap: pickImage,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 70.0,
                    child: ClipOval(
                      child: imageProvider.getUserAvatar(),
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
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color.fromARGB(255, 255, 235, 190), Colors.white],
                ),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(S.of(context).change_username),
                          content: Text(S.of(context).enter_username),
                          actions: [
                            TextFormField(
                              controller: usernameController,
                              onChanged: (value) {
                                imageProvider.changeUsername(value);
                              },
                              onFieldSubmitted: (value) {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    child: TextField2(
                      icon: const Icon(Icons.person_outline),
                      text: imageProvider.username,
                    ),
                  ),
                  TextField2(
                    icon: const Icon(Icons.email_outlined),
                    text: imageProvider.email,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: S.of(context).change_language,
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
                  child: Text(S.of(context).yes),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(S.of(context).no),
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
