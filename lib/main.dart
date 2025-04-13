import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pizza_time/presentation/providers/image_provider.dart';
import 'package:pizza_time/presentation/responsive.dart';
import 'package:pizza_time/presentation/mobileScreens/forgotPassword.dart';
import 'package:pizza_time/presentation/mobileScreens/login.dart';
import 'package:pizza_time/presentation/mobileScreens/signup.dart';
import 'package:pizza_time/generated/l10n.dart';
import 'package:pizza_time/presentation/providers/language_provider.dart';
import 'package:pizza_time/presentation/mobileScreens/account_screen.dart';
import 'package:pizza_time/presentation/mobileScreens/home_screen.dart';
import 'package:pizza_time/presentation/mobileScreens/oreders_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => ImageProvider1()),
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
      home: const Responsive(),
    );
  }
}
