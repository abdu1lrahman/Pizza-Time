import 'package:flutter/material.dart';
import 'package:pizza_time/presentation/providers/image_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsernameSelectionPage extends StatelessWidget {
  final String email; // Pass the email from Google login
  final TextEditingController _usernameController = TextEditingController();

  UsernameSelectionPage({required this.email, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<ImageProvider1>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // App logo/icon
            const Icon(
              Icons.local_pizza,
              size: 80,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            // Welcome text
            Text(
              'Welcome to Pizza Time!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.red[800],
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            // Instruction text
            Text(
              'Please choose a username to continue',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            // Email display (from Google login)
            Text(
              'Logged in as: $email',
              style: TextStyle(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // Username input field
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'e.g. pizza_lover',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
            const SizedBox(height: 20),

            // Continue button
            ElevatedButton(
              onPressed: () async {
                // Validate and save username
                if (_usernameController.text.trim().isNotEmpty) {
                  Navigator.pushReplacementNamed(context, 'home');
                }
                authProvider.changeUsername(_usernameController.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Skip for now option
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'home');
              },
              child: Text(
                'Skip for now',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
