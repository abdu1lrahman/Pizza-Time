import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pizza_time/core/components/imageBlur.dart';
import 'package:pizza_time/core/components/text_field.dart';
import 'package:pizza_time/core/constants/constants.dart';
import 'package:pizza_time/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            child: Imageblur(
              text: S.of(context).Register,
              imagePath: 'assets/images/food2.jpg',
            ),
          ),
          const SizedBox(height: 15.0),
          SizedBox(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  deafultTextField(
                    label: 'UserName',
                    controller: username,
                    validator: (value) {
                      return;
                    },
                  ),
                  deafultTextField(
                    controller: email,
                    label: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  deafultTextField(
                    obscureText: true,
                    controller: password,
                    label: 'Password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  deafultTextField(
                    obscureText: true,
                    controller: passwordController,
                    label: 'Confirm Password',
                    textInputAction: TextInputAction.go,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password again';
                      } else if (value != password.text) {
                        return 'Passwords mismatch. Please re-enter';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: secondryColor,
                      ),
                      width: double.infinity,
                      height: 50,
                      child: MaterialButton(
                        child: Text(
                          S.of(context).register,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            try {
                              // ignore: unused_local_variable
                              final credential = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: email.text,
                                password: password.text,
                              );
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('userName', username.text);
                              prefs.setString('email', email.text);
                              debugPrint('user added succsesfuly');
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                debugPrint(
                                    'The password provided is too weak.');
                              } else if (e.code == 'email-already-in-use') {
                                debugPrint(
                                    'The account already exists for that email.');
                              }
                            } catch (e) {
                              debugPrint(e.toString());
                            }
                          }
                          //Navigator.pushReplacementNamed(context, 'home');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
