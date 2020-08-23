import 'package:amber_store/app/home/models/cart.dart';
import 'package:flutter/cupertino.dart';

class OrderItem {
  OrderItem({
   @required this.id,
   @required this.amount,
   @required this.products,
   @required this.dateTime,
  });

  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
}
