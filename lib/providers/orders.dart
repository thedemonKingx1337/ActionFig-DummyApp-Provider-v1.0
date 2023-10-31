import 'package:flutter/material.dart';
import 'cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orderItems = [];
  List<OrderItem> get orderItems => [..._orderItems];

  void addOders(
    List<CartItem> cartProducts,
    double totalAmount,
  ) {
    _orderItems.insert(
        0,
        OrderItem(
          id: DateTime.now().toString(),
          amount: totalAmount,
          products: cartProducts,
          dateTime: DateTime.now(),
        ));
    notifyListeners();
  }
}
