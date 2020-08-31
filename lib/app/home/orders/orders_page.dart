import 'package:amber_store/app/home/models/orders.dart';
import 'package:amber_store/app/home/orders/order_item_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
    static const routeName = '/orders-page';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i) => OrderItemListTile(
          order: orderData.orders[i],
        ),
      ),
    );
  }
}
