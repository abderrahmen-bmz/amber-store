// import 'package:amber_store/app/home/home_page.dart';

import 'package:amber_store/app/home/cart/cart_page.dart';
import 'package:amber_store/app/home/home_page.dart';
import 'package:amber_store/app/home/models/cart.dart';
import 'package:amber_store/app/home/models/orders.dart';
import 'package:amber_store/app/home/orders/orders_page.dart';
import 'package:amber_store/app/home/products/all_products_page.dart';
import 'package:amber_store/app/home/products/edit_product._page.dart';
import 'package:amber_store/app/home/products/product_detail_page.dart';
import 'package:amber_store/app/home/products/products_page.dart';
import 'package:amber_store/app/sign_in/sign_in_page.dart';
import 'package:amber_store/services/authentication/auth.dart';
import 'package:amber_store/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<Database>(
            create: (_) => FirestoreDatabase(),
          ),
          Provider<AuthBase>(
            create: (_) => Auth(),
          ),
          ChangeNotifierProvider.value(
            value: Cart(),
          ),
          ChangeNotifierProvider.value(
            value: Orders(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Amber-Store',
          theme: ThemeData(
            primarySwatch: Colors.amber,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: HomePage(),
          routes: {
            ProductsPage.routeName: (ctx) => ProductsPage(),
            ProductDetailPage.routeName: (ctx) => ProductDetailPage(),
            CartPage.routeName: (ctx) => CartPage(),
            OrdersPage.routeName: (ctx) => OrdersPage(),
          },
        ));
  }
}
