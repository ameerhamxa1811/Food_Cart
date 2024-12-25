import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_cart/provider/login_provider.dart';
import 'package:food_cart/provider/product_detail_provider.dart';
import 'package:food_cart/provider/product_provider.dart';
import 'package:food_cart/screens/login_screen.dart';
import 'package:food_cart/screens/product_detail_screen.dart';
import 'package:food_cart/screens/product_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Important for Firebase and Stripe
  Stripe.publishableKey = 'pk_test_51QZuooF3y7cUPl2iZY5bNioUkzOVwJ1kRiBD7oJEac1UaIONQgDxODmB70lwzKAAkBhlZo46blwlhZCNom3skDjq00OkXHomT6'; // Replace with your publishable key
  await Firebase.initializeApp(); // Initialize Firebase
  await Stripe.instance.applySettings(); // Apply Stripe settings
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(
          create: (_) => LoginProvider(),
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (_) => ProductProvider(),
        ),
        ChangeNotifierProvider<ProductDetailProvider>(
          create: (_) => ProductDetailProvider(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true, // Ensures text scales properly

        builder: (context, child) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: LoginScreen(),
          );
        },
      ),
    );
  }
}