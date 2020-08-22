import 'dart:async';

import 'package:amber_store/services/api_path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:amber_store/app/home/models/product.dart';
import 'package:flutter/cupertino.dart';

abstract class Database {
  // Future<void> setProduct(Product product);
  // Future<void> deleteProduct(Product product);
  // Stream<List<Product>> productsStream();
  // Stream<Product> productStream({@required String productId});
   
   // Single set methpd fpr create and update
  Future<void> setProduct(Product product);
  //Future<void> createProduct(Map<String , dynamic> productData);
  Stream<List<Product>> productsStream();
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

// add Provider to Product page
class FirestoreDatabase implements Database {
  // Future<void> createProduct(Map<String, dynamic> productData) async {
  //   final path = '/products/google101';//APIPath.product("productId");
  //   final documentReference = Firestore.instance.document(path);
  //   await documentReference.setData(productData);
  // }

  // Stream<List<Product>> productsStream() {
  //   final path = APIPath.products();
  //   final reference = Firestore.instance.collection(path);
  //   final snapshots = reference.snapshots();
  //   return snapshots.map(
  //     (snapshot) => snapshot.documents
  //         .map((snapshot) => Product.fromMap(snapshot.data))
  //         .toList(),
  //   );
  // }

  Future<void> setProduct(Product product) async => await _setData(
        path: APIPath.product(product.id),
        data: product.toMap(),
      );

  Stream<List<Product>> productsStream() => _collectionStream(
        path: APIPath.products(),
        builder: (data, documentId) => Product.fromMap(
          data,
          documentId,
        ),
      );

  // add generic setData method
  Future<void> _setData({String path, Map<String, dynamic> data}) async {
    final reference = Firestore.instance.document(path);
    print('$path : $data');
    await reference.setData(data);
  }

  Stream<List<T>> _collectionStream<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data, String documentId),
  }) {
    final reference = Firestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map(
      (snapshot) => snapshot.documents
          .map((snapshot) => builder(
                snapshot.data,
                snapshot.documentID,
              ))
          .toList(),
    );
  }
}
