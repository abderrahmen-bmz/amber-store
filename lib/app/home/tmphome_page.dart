import 'package:amber_store/app/home/models/product.dart';
import 'package:amber_store/app/home/products/list_items_builder.dart';
import 'package:amber_store/app/home/products/product_detail_page.dart';
import 'package:amber_store/common_widgets/app_drawer.dart';
import 'package:amber_store/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TmpHomePage extends StatelessWidget {
  static const routeName = '/home-page';

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
      drawer: AppDrawer(),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(context) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<Product>>(
      stream: database.productsStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder(
            snapshot: snapshot,
            itemBuilder: (context, product) => Center(
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              ProductDetailPage.routeName,
                              arguments: product.id,
                            );
                          },
                          child: Container(
                            color: Colors.grey,
                           // width: 100.0,
                            height: 100.0,
                            child: Image.network(
                              product.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const ListTile(
                          leading: Icon(Icons.album),
                          title: Text('The Enchanted Nightingale'),
                          subtitle: Text(
                              'Music by Julie Gable. Lyrics by Sidney Stein.'),
                        ),
                        ButtonBar(children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.shopping_cart,
                              color: Colors.amber,
                            ),
                            onPressed: null,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.amber,
                            ),
                            onPressed: (){},
                          ),
                        ])
                      ],
                    ),
                  ),
                )
            //  Card(
            //   child: Row(
            //     children: [
            //       GestureDetector(
            //         onTap: () {
            //           Navigator.of(context).pushNamed(
            //             ProductDetailPage.routeName,
            //             arguments: product.id,
            //           );
            //         },
            //         child: Container(
            //           color: Colors.grey,
            //           width: 100.0,
            //           height: 100.0,
            //           child: Image.network(
            //             product.imageUrl,
            //             fit: BoxFit.cover,
            //           ),
            //         ),
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
