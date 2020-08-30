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
    return Card(
      child: ListTile(
        leading: Image.network(product.imageUrl),
        title: Text(product.name),
        subtitle: Text(product.description),
        trailing: Icon(
          Icons.edit,
          color: Colors.green,
        ),
        onTap: onTap,
      ),
    );
  }
}
