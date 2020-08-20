import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:amber_store/app/home/models/product.dart';

abstract class Database {
  Future<void> setProduct(Product product);
  Future<void> deleteProduct(Product product);
  Stream<List<Product>> productsStream();
  Stream<Product> productStream({@required String productId});

  Future<void> createProduct(Map<String, dynamic> productData);
}

// add Provider to Product page
class FirestoreDatabase implements Database {
  // FirestoreDatabase({@required this.pid}) : assert(pid != null);
  // final String pid; // pid

  int id = 0202;
  Future<void> createProduct(Map<String, dynamic> productData) async {
    final path = '/products/$id/new_product';
    final documentReference = Firestore.instance.document(path);
    await documentReference.setData(productData);
  }




  Future<void> createJob0(Product product) async {
    final path = '/products/new_product';
    final documentReference = Firestore.instance.document(path);
    await documentReference.setData(product.toMap());
  }

  @override
  Future<void> deleteProduct(Product product) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Stream<Product> productStream({String productId}) {
    // TODO: implement jobStream
    throw UnimplementedError();
  }

  @override
  Stream<List<Product>> productsStream() {
    // TODO: implement productsStream
    throw UnimplementedError();
  }

  @override
  Future<void> setProduct(Product product) {
    // TODO: implement setProduct
    throw UnimplementedError();
  }
}
