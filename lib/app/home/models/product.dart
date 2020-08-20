import 'package:flutter/foundation.dart';

class Product {
  Product({
    @required this.name,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite,
  });

  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
  }

  // Convert Object to Map of key value pairs + for firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
