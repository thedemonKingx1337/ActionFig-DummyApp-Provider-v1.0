import 'package:flutter/material.dart';
import '../widgets/orderItems.dart' as OrderScreenWidget;
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/mainDrawer.dart';

class OrderScreen extends StatelessWidget {
  static const routName = "/order_page";
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context, listen: false);
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(title: Text("Orders")),
      body: ListView.builder(
          itemCount: orderData.orderItems.length,
          itemBuilder: (context, index) =>
              OrderScreenWidget.OrderItems(orderData.orderItems[index])),
    );
  }
}
