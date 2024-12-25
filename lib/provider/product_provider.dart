import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Product Model
class Product {
  final String name;
  final String location;
  final double price;
  final String image;

  Product({
    required this.name,
    required this.location,
    required this.price,
    required this.image,
  });
}

// Product Provider
class ProductProvider extends ChangeNotifier {
  final List<Product> _products = [
    Product(
      name: 'Scobedo Burger',
      location: 'Cibadak Market',
      price: 34,
      image: 'burger',
    ),
    Product(
      name: 'Vegan Burger',
      location: 'Cibadak Market',
      price: 42,
      image: 'burger',
    ),
    Product(
      name: 'Scobedo Burger',
      location: 'Cibadak Market',
      price: 34,
      image: 'burger.jpg',
    ),
    Product(
      name: 'Vegan Burger',
      location: 'Cibadak Market',
      price: 42,
      image: 'burger',
    ),
    Product(
      name: 'Scobedo Burger',
      location: 'Cibadak Market',
      price: 34,
      image: 'burger.jpg',
    ),
    Product(
      name: 'Vegan Burger',
      location: 'Cibadak Market',
      price: 42,
      image: 'burger',
    ),
  ];

  List<Product> get products => _products;
}