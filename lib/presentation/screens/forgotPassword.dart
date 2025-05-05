import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pizza_time/core/components/text_field.dart';
import 'package:pizza_time/generated/l10n.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  TextEditingController email = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).reset_password),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Image.asset(
                'assets/images/pizza6.png',
                width: screenWidth * 0.7,
              ),
              const SizedBox(height: 10),
              Text(
                S.of(context).forgot,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.06,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Text(
                  S.of(context).enter_email,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: screenWidth * 0.04,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Form(
                  key: formKey,
                  child: deafultTextField(
                    label: 'email',
                    controller: email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).empty_email;
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16), // Big rounded corners
                    ),
                    textColor: Colors.white,
                    color: const Color(0xffdd6e39),
                    child: Text(
                      S.of(context).send,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // Send password reset email
                        FirebaseAuth.instance
                            .sendPasswordResetEmail(email: email.text)
                            .then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Password reset email sent to $email'),
                            ),
                          );
                        }).catchError((error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Failed to send email'),
                            ),
                          );
                        });
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
