import 'package:amber_store/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget {
  Future<void> _createProduct(BuildContext context) async {
    final database = Provider.of<Database>(context);
    await database.createProduct(
      {
        'name': 'Blogging',
        'reteHour': 10,
      },
    );
    print("its Done ??? ==========");
  }

  // int id = 0202;
  // Future<void> createProduct() async {
  //   final path = '/products/$id/new_product';
  //   final documentReference = Fire.instance.doc(path);
  //   await documentReference.set(
  //     {
  //       'name': 'Blogging',
  //       'reteHour': 10,
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        centerTitle: true,
        title: Text(
          'Amber Store',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () => _createProduct(context),
          ),
        ],
      ),
     
    );
  }
}
