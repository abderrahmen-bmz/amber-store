import 'package:amber_store/app/home/models/orders.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';




class OrderItemListTile extends StatelessWidget {
  final OrderItem order;

  OrderItemListTile({@required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
           title: Text('\$${order.amount}'),
            subtitle: Text(
             DateFormat('dd/MM/yyyy hh:mm').format(order.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
