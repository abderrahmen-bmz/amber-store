import 'package:amber_store/app/home/models/product.dart';
import 'package:amber_store/app/home/products/edit_product._page.dart';
import 'package:amber_store/app/home/products/list_items_builder.dart';
import 'package:amber_store/app/home/products/product._list_tile.dart';
import 'package:amber_store/common_widgets/platform_exception_alert_dialog.dart';
import 'package:amber_store/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget {

  static const routeName = '/products-page';
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

  Future<void> _deleteProduct(BuildContext context, Product product) async {
    try {
      final database = Provider.of<Database>(context, listen: false);
      await database.deleteProduct(product);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Operation Failed',
        exception: e,
      ).show(context);
    }
  }

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
          'My Products',
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
               Dismissible(
                key: Key('product-${product.id}'),
                background: Container(
                  color: Colors.red,
                  child: Text("Delete",style: TextStyle(color:Colors.white,fontSize: 25.00,),),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) => _deleteProduct(context, product),
                child: ProductListTile(
                  product: product,
                  onTap: () => EditProductPage.show(context, product: product),
                ),
              ),
              //**************************************** */
          //     Card(
          //   child: Row(
          //     children: [
          //       Container(
          //         color: Colors.grey,
          //         width: 100.0,
          //         height: 100.0,
          //       ),
          //       SizedBox(
          //         width: 10.0,
          //       ),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             product.name,
          //             style: TextStyle(fontSize: 20.0),
          //           ),
          //           Text(product.price.toString(),
          //               style: TextStyle(
          //                 color: Colors.grey[450],
          //               )),
          //           ButtonBar(children: <Widget>[
          //             IconButton(
          //               icon: Icon(
          //                 Icons.shopping_cart,
          //                 color: Colors.amber,
          //               ),
          //               onPressed: null,
          //             ),
          //             IconButton(
          //               icon: Icon(
          //                 Icons.favorite,
          //                 color: Colors.amber,
          //               ),
          //               onPressed: null,
          //             ),
          //           ])
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
        );

     
      },
    );
  }
}
