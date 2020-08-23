import 'package:amber_store/app/home/home_page.dart';
import 'package:amber_store/app/home/products/product_detail_page.dart';
import 'package:amber_store/app/home/products/products_page.dart';
import 'package:amber_store/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main()  {
 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<Database>(
      create: (_) => FirestoreDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Amber-Store',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
        routes: {
        ProductsPage.routeName : (ctx) => ProductsPage(),
        ProductDetailPage.routeName  : (ctw) => ProductDetailPage(),
        },
      ),
    );
  }
}
