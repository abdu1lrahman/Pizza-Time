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
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).reset_password),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/images/pizza6.png',
            width: width * 0.7,
          ),
          Text('FORGOT PASSWORD'),
          Text(
            'Enter your email address and we\'ll send you a link to reset your password.',
            textAlign: TextAlign.center,
          ),
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
          MaterialButton(
            child: Text(S.of(context).send),
            // child: Text('send'),

            onPressed: () {
              if (formKey.currentState!.validate()) {
                // Send password reset email
                FirebaseAuth.instance
                    .sendPasswordResetEmail(email: email.text)
                    .then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Password reset email sent to $email'),
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
        ],
      ),
    );
  }
}
