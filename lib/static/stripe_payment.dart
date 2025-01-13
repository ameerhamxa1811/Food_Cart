import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StripePayment {
  String get trace {
    final stackTrace = StackTrace.current;
    final frames = stackTrace.toString().split('\n');

    if (frames.length > 1) {
      final callerFrame = frames[1].trim();
      final regex = RegExp(r'#\d+\s+(\S+)\.(\S+)\s+\(.*\)');
      final match = regex.firstMatch(callerFrame);

      if (match != null) {
        final className = match.group(1);
        final methodName = match.group(2);
        return "$className::$methodName";
      } else {
        return "$runtimeType::unknown";
      }
    } else {
      return "$runtimeType::unknown";
    }
  }

  Future<Map<String, dynamic>> makePayment({
    required String price,
    String currency = 'PKR',
  }) async {
    try {
      // Convert price to cents for Stripe (smallest unit)
      final double priceValue = double.parse(price);
      final int amountInCents = (priceValue * 100).toInt();

      // Check if the amount meets Stripe's minimum requirements
      if (currency.toUpperCase() == 'PKR' && amountInCents < 50) {
        throw Exception(
            "Amount too small: Must convert to at least 50 cents in PKR.");
      }

      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51QZuooF3y7cUPl2i4QFPu1jTeLaP2t241kg0KQqXvLcSzVQcHcRLARXKfqb35N6cdtJSAJPTVnBY7nUZ0n4AGP8j00JJAroaJ6',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'amount': amountInCents.toString(),
          'currency': currency.toLowerCase(),
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to create payment intent: ${response.body}');
      }

      return jsonDecode(response.body);
    } catch (e) {
      print("Error creating payment intent: $e");
      rethrow;
    }
  }

  /// Initializes the Stripe Payment Sheet
  Future<void> initPaymentSheet({
    required String paymentIntentClientSecret,
  }) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: 'Food Cart',
        ),
      );
    } catch (e) {
      print("Error initializing payment sheet: $e");
      rethrow;
    }
  }

  /// Displays the Payment Sheet to the user
  Future<bool> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      return true;
    } catch (e) {
      print("Error displaying payment sheet: $e");
      rethrow;
    }
  }
}
