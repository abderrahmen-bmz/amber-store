import 'dart:math';

import 'package:amber_store/app/home/models/orders.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';




class OrderItemListTile extends StatefulWidget {
  final OrderItem order;

  OrderItemListTile({@required this.order});

  @override
  _OrderItemListTileState createState() => _OrderItemListTileState();
}

class _OrderItemListTileState extends State<OrderItemListTile> {
  var _expanded = false; 
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
           title: Text('\$${widget.order.amount}'),
            subtitle: Text(
             DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded) Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            height: min(widget.order.products.length * 20.0 + 10, 100),
            child: ListView(
                children: widget.order.products
                    .map(
                      (prod) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                prod.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${prod.quantity}x \$${prod.price}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                    )
                    .toList(),
              ),
            ),
        ],
      
      ),
    );
  }
}
