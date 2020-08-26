import 'dart:async';
import 'package:amber_store/services/api_path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:amber_store/app/home/models/product.dart';
import 'package:flutter/cupertino.dart';

abstract class Database {
  // Single set methpd fpr create and update
  Future<void> setProduct(Product product);
  //Future<void> createProduct(Map<String , dynamic> productData);
  Stream<List<Product>> productsStream();
  Future<void> deleteProduct(Product product);
  Stream<Product> findProductById(String productId);
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

  @override
  Future<void> setProduct(Product product) async => await _setData(
        path: APIPath.product(product.id),
        data: product.toMap(),
      );

  @override
  Stream<List<Product>> productsStream() => _collectionStream(
        path: APIPath.products(),
        builder: (data, documentId) => Product.fromMap(
          data,
          documentId,
        ),
      );

  @override
  Future<void> deleteProduct(Product product) async =>
      await _deleteData(path: APIPath.product(product.id));

  // add generic setData method
  Future<void> _setData({
    @required String path,
    @required Map<String, dynamic> data,
  }) async {
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

  Future<void> _deleteData({@required String path}) async {
    final reference = Firestore.instance.document(path);
    print('this path hasbeen delete : $path');
    await reference.delete();
  }

  /// Test Code
  ///
  @override
  Stream<Product> findProductById(String productId) {
    // final DocumentReference reference = Firestore.instance.document(APIPath.product(productId));
    // final Stream<DocumentSnapshot> snapshots = reference.snapshots();
    // return snapshots.map(
    //   (snapshot) => Product.fromMap(snapshot.data, snapshot.documentID),
    // );

     return _documentStream<Product>(
        path: APIPath.product(productId),
        builder: (data, documentID) => Product.fromMap(data, documentID),
      );
 
  }


  Stream<T> _documentStream<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data, String documentID),
  }) {
    final DocumentReference reference = Firestore.instance.document(path);
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();
    return snapshots
        .map((snapshot) => builder(snapshot.data, snapshot.documentID));
  }
}
