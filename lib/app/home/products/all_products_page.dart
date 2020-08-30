import 'package:amber_store/app/home/cart/cart_page.dart';
import 'package:amber_store/app/home/models/cart.dart';
import 'package:amber_store/app/home/models/product.dart';
import 'package:amber_store/app/home/products/badge.dart';
import 'package:amber_store/app/home/products/list_items_builder.dart';
import 'package:amber_store/common_widgets/app_drawer.dart';
import 'package:amber_store/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllProdcuts extends StatefulWidget {
  @override
  _AllProdcutsState createState() => _AllProdcutsState();
}

class _AllProdcutsState extends State<AllProdcuts> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
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
          Badge(
            color: Colors.red,
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartPage.routeName);
              },
            ),
            value: cart.itemCount.toString(),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return StreamBuilder<List<Product>>(
      stream: database.productsStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder(
            snapshot: snapshot,
            itemBuilder: (context, product) => Stack(
                  children: [
                    Card(
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: const Color(0xff7c94b6),
                              image: DecorationImage(
                                image: NetworkImage(product.imageUrl),
                                fit: BoxFit.cover,
                              ),
                              // border: Border.all(
                              //   color: Colors.black,
                              //   width: 8,
                              // ),
                              //   borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          ListTile(
                            title: Text(product.name),
                            subtitle: Text(product.description),
                            trailing: Text(product.price.toString()),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        //  crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 60,
                            width: 60,
                            child: RaisedButton(
                              child: Icon(
                                Icons.add_shopping_cart,
                                color: Colors.white,
                              ),
                              color: Colors.orange,
                              // disabledColor: color,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(60),
                                ),
                              ),
                              onPressed: () {
                                cart.addItem(
                                  productId: product.id,
                                  price: product.price,
                                  title: product.name,
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          SizedBox(
                            height: 60,
                            width: 60,
                            child: RaisedButton(
                              child: product.isFavorite
                                  ? Icon(
                                      Icons.favorite,
                                      color: Colors.orange,
                                    )
                                  : Icon(
                                      Icons.favorite_border,
                                      color: Colors.orange,
                                    ),
                              color: Colors.white,
                              // disabledColor: color,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(60),
                                ),
                              ),
                              onPressed: () {
                                database.setProduct(
                                  product = Product(
                                    id: product.id,
                                    name: product.name,
                                    description: product.description,
                                    price: product.price,
                                    imageUrl: product.imageUrl,
                                    isFavorite:
                                        product.isFavorite ? false : true,
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
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
