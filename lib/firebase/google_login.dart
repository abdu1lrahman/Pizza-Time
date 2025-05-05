import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pizza_time/presentation/providers/image_provider.dart';
import 'package:pizza_time/presentation/screens/user_selection_page.dart';
import 'package:provider/provider.dart';

Future signInWithGoogle(BuildContext context) async {
  final imagePrivder = Provider.of<ImageProvider1>(context, listen: false);
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  if (googleUser == null) {
    return;
  }

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  await FirebaseAuth.instance.signInWithCredential(credential);

  final userEmail = FirebaseAuth.instance.currentUser?.email;
  imagePrivder.changeEmail(userEmail!);
  // ignore: use_build_context_synchronously
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => UsernameSelectionPage(email: userEmail),
      ),
      (route) => false);
}
