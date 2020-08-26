import 'package:amber_store/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context).settings.arguments as String; // is the unique ID

    final loadedProduct = Provider.of<Database>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Container(
          child: StreamBuilder(
              stream: loadedProduct.findProductById(productId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading");
                }
                var productDocument = snapshot.data;

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          //  color: Colors.grey,
                          width: 400.0,
                          height: 400.0,
                          // height: MediaQuery.of(context).size.height,
                          // width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            //   image: Image.network(productDocument.imageUrl,),
                            image: DecorationImage(
                                image: NetworkImage(productDocument.imageUrl),
                                fit: BoxFit.cover),
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                          ),
                          child: ListTile(
                            title: Text(productDocument.name),
                            subtitle: Text(productDocument.description),
                            trailing: Text(productDocument.price.toString()),
                          ),
                        ),
                        ButtonBar(
                          children: <Widget>[
                            Container(
                              width: 150.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.favorite_border,
                                      color: Colors.grey,
                                    ),
                                    onPressed: null,
                                  ),
                                  Text(
                                    'Add to Wishlist',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: 150.0,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.add_shopping_cart,
                                      color: Colors.white,
                                    ),
                                    onPressed: (){
                                    // final database = Provider.of<Database>(context);
                                    // database.setProduct(productDocument.name = '');
                                    },
                                  ),
                                  Text(
                                    'Add to Cart',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
