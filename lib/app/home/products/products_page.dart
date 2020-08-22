import 'package:amber_store/app/home/models/product.dart';
import 'package:amber_store/app/home/products/edit_product._page.dart';
import 'package:amber_store/app/home/products/list_items_builder.dart';
import 'package:amber_store/app/home/products/product._list_tile.dart';
import 'package:amber_store/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget {
  // Future<void> _createProduct(BuildContext context) async {
  //   final database = Provider.of<Database>(context, listen: false);
  //   await database.setProduct(
  //     Product(
  //       id: ,
  //       name: 'YesMan',
  //       description: 'Nice Product',
  //       price: 120.00,
  //       imageUrl: 'http//www.googleurl.com',
  //     ),
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
            onPressed: () {},
          ),
        ],
      ),
      body: _buildContents(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => EditProductPage.show(context),
      ),
    );
  }

  Widget _buildContents(context) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<Product>>(
      stream: database.productsStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder(
          snapshot: snapshot,
          itemBuilder: (context, product) =>
              ProductListTile(
                product: product,
                onTap: () => EditProductPage.show(context, product: product),
              ),
          //     Card(
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       ListTile(
          //         leading: CircleAvatar(
          //           child: Icon(Icons.album),
          //         ),
          //         title: Text('The Enchanted Nightingale'),
          //         subtitle: Text('Music by Julie Gable'),
          //       ),
          //       ButtonBar(children: <Widget>[
          //         IconButton(
          //           icon: Icon(
          //             Icons.shopping_cart,
          //             color: Colors.amber,
          //           ),
          //           onPressed: null,
          //         ),
          //         IconButton(
          //           icon: Icon(
          //             Icons.favorite,
          //             color: Colors.amber,
          //           ),
          //           onPressed: null,
          //         ),
          //       ])
          //     ],
          //   ),
          // ),
        );
        //   if (snapshot.hasData) {
        //     final products = snapshot.data;
        //     final children = products
        //         .map((product) => ProductListTile(
        //               product: product,
        //               onTap: () => EditProductPage.show(context,product: product),
        //             ))
        //         .toList();
        //     return ListView(
        //       children: children,
        //     );
        //   }
        //   if (snapshot.hasError) {
        //     return Center(
        //       child: Text('Some Error occurred '),
        //     );
        //   }
        //   return Center(
        //     child: CircularProgressIndicator(),
        //   );
      },
    );
  }
}
