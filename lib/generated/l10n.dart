// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Order your pizza now`
  String get title {
    return Intl.message(
      'Order your pizza now',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `are you sure you want to logout`
  String get logout_confirm {
    return Intl.message(
      'are you sure you want to logout',
      name: 'logout_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `The Future of pizza ordrer`
  String get future {
    return Intl.message(
      'The Future of pizza ordrer',
      name: 'future',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get order_title {
    return Intl.message('My Orders', name: 'order_title', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `My Account`
  String get my_account {
    return Intl.message('My Account', name: 'my_account', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Change Language`
  String get change_language {
    return Intl.message(
      'Change Language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `do you want to change language into arabic`
  String get change_language_confirm {
    return Intl.message(
      'do you want to change language into arabic',
      name: 'change_language_confirm',
      desc: '',
      args: [],
    );
  }

  /// `language changed successfully`
  String get change_language_success {
    return Intl.message(
      'language changed successfully',
      name: 'change_language_success',
      desc: '',
      args: [],
    );
  }

  /// `sign up to start your journy`
  String get register {
    return Intl.message(
      'sign up to start your journy',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register1 {
    return Intl.message('Register', name: 'register1', desc: '', args: []);
  }

  /// `Don't have an account?`
  String get dont_have_an_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dont_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `or Login With`
  String get orloginwith {
    return Intl.message(
      'or Login With',
      name: 'orloginwith',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get reset_password {
    return Intl.message(
      'Reset Password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get fogot_password {
    return Intl.message(
      'Forgot Password?',
      name: 'fogot_password',
      desc: '',
      args: [],
    );
  }

  /// `email can not be empty`
  String get empty_email {
    return Intl.message(
      'email can not be empty',
      name: 'empty_email',
      desc: '',
      args: [],
    );
  }

  /// `back`
  String get back {
    return Intl.message('back', name: 'back', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Vegetarian`
  String get vegetarian {
    return Intl.message('Vegetarian', name: 'vegetarian', desc: '', args: []);
  }

  /// `Pepperoni`
  String get pepperoni {
    return Intl.message('Pepperoni', name: 'pepperoni', desc: '', args: []);
  }

  /// `BBQ Chicken`
  String get bbq {
    return Intl.message('BBQ Chicken', name: 'bbq', desc: '', args: []);
  }

  /// `Margherita`
  String get margherita {
    return Intl.message('Margherita', name: 'margherita', desc: '', args: []);
  }

  /// `Hawaiian`
  String get hawaiian {
    return Intl.message('Hawaiian', name: 'hawaiian', desc: '', args: []);
  }

  /// `Pizza Details`
  String get pizza_details {
    return Intl.message(
      'Pizza Details',
      name: 'pizza_details',
      desc: '',
      args: [],
    );
  }

  /// `add to cart`
  String get add_chart {
    return Intl.message('add to cart', name: 'add_chart', desc: '', args: []);
  }

  /// `Loaded with bell peppers, mushrooms, onions, olives, and tomatoes`
  String get loaded {
    return Intl.message(
      'Loaded with bell peppers, mushrooms, onions, olives, and tomatoes',
      name: 'loaded',
      desc: '',
      args: [],
    );
  }

  /// `SEND`
  String get send {
    return Intl.message('SEND', name: 'send', desc: '', args: []);
  }

  /// `FORGOT PASSWORD`
  String get forgot {
    return Intl.message('FORGOT PASSWORD', name: 'forgot', desc: '', args: []);
  }

  /// `Enter your email address and we'll send you a link to reset your password.`
  String get enter_email {
    return Intl.message(
      'Enter your email address and we\'ll send you a link to reset your password.',
      name: 'enter_email',
      desc: '',
      args: [],
    );
  }

  /// `Your email and username are private and won't be visible to other users.`
  String get your_email_and_username {
    return Intl.message(
      'Your email and username are private and won\'t be visible to other users.',
      name: 'your_email_and_username',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to change your username?`
  String get change_username {
    return Intl.message(
      'Do you want to change your username?',
      name: 'change_username',
      desc: '',
      args: [],
    );
  }

  /// `Enter your new username`
  String get enter_username {
    return Intl.message(
      'Enter your new username',
      name: 'enter_username',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
