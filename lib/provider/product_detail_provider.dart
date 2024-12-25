import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ProductDetail Model
class ProductDetail {
  final String name;
  final String description;
  final double price;
  final String image;
  final double rating;
  final String time;

  ProductDetail({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.rating,
    required this.time,
  });
}

// ProductDetail Provider
class ProductDetailProvider extends ChangeNotifier {
  final ProductDetail _productDetail = ProductDetail(
    name: 'Meatballs',
    description:
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip',
    price: 22.65,
    image:
    'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/Spaghetti_and_meatballs_3.jpg/1280px-Spaghetti_and_meatballs_3.jpg', // Replace with your image URL
    rating: 4.9,
    time: '10-15 min',
  );

  ProductDetail get productDetail => _productDetail;
}
