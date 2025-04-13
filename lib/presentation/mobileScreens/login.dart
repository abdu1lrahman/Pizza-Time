import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pizza_time/core/components/buttons.dart';
import 'package:pizza_time/core/components/imageBlur.dart';
import 'package:pizza_time/core/components/text_field.dart';
import 'package:pizza_time/core/constants/constants.dart';
import 'package:pizza_time/firebase/google_login.dart';
import 'package:pizza_time/generated/l10n.dart';
import 'package:pizza_time/presentation/providers/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            
            child: Imageblur(
              text: S.of(context).future,
              imagePath: 'assets/images/food1.jpg',
            ),
          ),
          const SizedBox(height: 15.0),
          SizedBox(
            
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  deafultTextField(
                    controller: email,
                    label: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      } else {
                        return null;
                      }
                    },
                  ),
                  deafultTextField(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, top: 12),
                    obscureText: true,
                    controller: password,
                    label: 'Password',
                    textInputAction: TextInputAction.go,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Container(
                    alignment: AlignmentDirectional.topEnd,
                    child: MaterialButton(
                      child: Text(S.of(context).fogot_password),
                      onPressed: () {
                        Navigator.pushNamed(context, 'forgotpassword');
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: secondryColor,
                      ),
                      width: double.infinity,
                      height: 50,
                      child: MaterialButton(
                        child: Text(
                          S.of(context).login,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.043,
                          ),
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            try {
                              // ignore: unused_local_variable
                              final credential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                email: email.text,
                                password: password.text,
                              );
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              pref.setBool('user_login', true);
                              Navigator.pushNamedAndRemoveUntil(
                                  context, 'home', (route) => false);
                            } on FirebaseAuthException catch (e) {
                              setState(() {
                                switch (e.code) {
                                  case 'user-not-found':
                                    _errorMessage =
                                        'No user found for that email.';
                                    break;
                                  case 'wrong-password':
                                    _errorMessage =
                                        'Wrong password provided for that user.';
                                    break;
                                  default:
                                    _errorMessage =
                                        'An unexpected error occurred. Please try again.';
                                }
                              });
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  if (_errorMessage != null)
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 14, right: 14, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(
                            color: mainGrey,
                            thickness: 1,
                          ),
                        ),
                        Text(
                          '  ${S.of(context).orloginwith}  ',
                          style: TextStyle(
                            fontSize: screenWidth * 0.043,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: mainGrey,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  deafultButton(
                    width: screenWidth / 3 - 20,
                    name: 'Google',
                    function: () async {
                      debugPrint(
                          "==========started google sgin in================");
                      signInWithGoogle(context);
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      pref.setBool('user_login', true);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenWidth * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(S.of(context).dont_have_an_account),
                        const SizedBox(width: 10),
                        GestureDetector(
                          child: Text(
                            S.of(context).register,
                            style: TextStyle(color: mainColor),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, 'signup');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: S.of(context).language,
        backgroundColor: Colors.black,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.language_outlined,
          color: Colors.white,
        ),
        onPressed: () {
          languageProvider.changeLanguage(
            Locale(languageProvider.locale.languageCode),
          );
        },
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
