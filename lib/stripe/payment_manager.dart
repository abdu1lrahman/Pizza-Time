import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentManager {
  Future<bool> makePayment(int amount, String currency) async {
    try {
      String clientSecret =
          await _getClientSecret((amount * 100).toString(), currency);
      await _initializePaymentSheet(clientSecret);
      await Stripe.instance.presentPaymentSheet();
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<void> _initializePaymentSheet(String clientSecret) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: "Pizza Time"),
    );
  }

  Future<String> _getClientSecret(String amount, String currency) async {
    final url = Uri.parse('https://api.stripe.com/v1/payment_intents');
    var response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer ${dotenv.env['stripeSecretKey']}',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: {
        'amount': amount,
        'currency': currency,
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['client_secret'];
    } else {
      debugPrint('Stripe error: ${response.body}');
      throw Exception('Stripe request failed: ${response.statusCode}');
    }
  }
}
