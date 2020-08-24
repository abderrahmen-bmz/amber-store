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
      body: Center(
        child: Container(
          child: StreamBuilder(
              stream: loadedProduct.findProductById(productId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading");
                }
                var productDocument = snapshot.data;

                return  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              ProductDetailPage.routeName,
                              arguments: productDocument.id,
                            );
                          },
                          child: Container(
                            color: Colors.grey,
                           // width: 100.0,
                            height: 100.0,
                            child: Image.network(
                              productDocument.imageUrl,
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
                            onPressed: null,
                          ),
                        ])
                      ],
                    ),
                  );
              }),
        ),
      ),
    );
  }
}
