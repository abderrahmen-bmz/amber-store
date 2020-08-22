import 'package:amber_store/app/home/models/product.dart';
import 'package:flutter/material.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({
    Key key,
    @required this.product,
    @required this.onTap,
  }) : super(key: key);

  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
     title: Text(product.name),
     trailing: Icon(Icons.chevron_right),
     onTap: onTap,
    );
  }
}
