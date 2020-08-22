import 'package:flutter/foundation.dart';

class Product {
  Product({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite,
  });

  final String id;
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

  factory Product.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    final String description = data['description'];
    final double price = data['price'];
    final String imageUrl = data['imageUrl'];
    return Product(
      id: documentId,
      name: name,
      description: description,
      price: price,
      imageUrl: imageUrl,
    );
  }
}
