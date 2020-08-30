import 'package:amber_store/app/home/cart/cart_item_list_tile.dart';
import 'package:amber_store/app/home/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  static const routeName = '/cart-page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Column(
      children: [
        Card(
          margin: EdgeInsets.all(15),
          child: Row(
            children: [
              Text(
                'Total',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(
                width: 10,
              ),
              Chip(
                label: Text('\$${cart.totalAmount}'),
                backgroundColor: Theme.of(context).accentColor,
              ),
              FlatButton(
                onPressed: () {},
                child: Text('ORDER NOW'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (ctx, i) => CartItemListTile(
              id: cart.items.values.toList()[i].id,
              productId: cart.items.keys.toList()[i],
              name: cart.items.values.toList()[i].title,
              price: cart.items.values.toList()[i].price,
              quantity: cart.items.values.toList()[i].quantity,
            ),
          ),
        ),
      ],
    );
  }
}
