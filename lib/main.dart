import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:pizza_time/presentation/providers/auth_provider.dart';
import 'package:pizza_time/presentation/providers/image_provider.dart';
import 'package:pizza_time/presentation/screens/forgotPassword.dart';
import 'package:pizza_time/presentation/screens/login.dart';
import 'package:pizza_time/presentation/screens/signup.dart';
import 'package:pizza_time/generated/l10n.dart';
import 'package:pizza_time/presentation/providers/language_provider.dart';
import 'package:pizza_time/presentation/screens/account_screen.dart';
import 'package:pizza_time/presentation/screens/home_screen.dart';
import 'package:pizza_time/presentation/screens/oreders_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "constants.env");
  Stripe.publishableKey = dotenv.env['stripePublishableKey']!;
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => ImageProvider1()),
        ChangeNotifierProvider(create: (context) => AuthProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return MaterialApp(
      locale: languageProvider.locale,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      routes: {
        'signup': (context) => const Signup(),
        'login': (context) => const Login(),
        'home': (context) => const HomeScreen(),
        'oreders': (context) => const OredersScreen(),
        'account': (context) => const AccountScreen(),
        'forgotpassword': (context) => const Forgotpassword(),
      },
      title: 'Pizza Time',
      debugShowCheckedModeBanner: false,
      home:
          authProvider.isSignedIn == true ? const HomeScreen() : const Login(),
    );
  }
}
