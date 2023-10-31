import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/orders.dart' as ORD;

class OrderItems extends StatefulWidget {
  // to avoid the name clash between OrderItems we used the prefix to make dart understand we need the class OrderItem from the oders.dart here.
  final ORD.OrderItem Order;
  OrderItems(this.Order);

  @override
  State<OrderItems> createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  var expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      child: Column(children: [
        ListTile(
          title: Text("₹ ${widget.Order.amount.toStringAsFixed(2)}"),
          subtitle: Text(
              DateFormat("dd-MM-yyyy h:mm:a").format(widget.Order.dateTime)),
          trailing: IconButton(
              onPressed: () {
                setState(() {
                  expanded = !expanded;
                });
              },
              icon: Icon(expanded ? Icons.expand_less : Icons.expand_more)),
          // min used for using minimum value out of 2 values
          // 2 values are  ==== product length x 20 + base height 100,other value is 180
        ),
        if (expanded)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            height: min(widget.Order.products.length * 20 + 20, 180),
            child: ListView(
                children: widget.Order.products
                    .map(
                      (product_iterated) => Row(
                        children: [
                          Text(
                            product_iterated.title,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "   ${product_iterated.quantity} x ₹ ${product_iterated.price}",
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          )
                        ],
                      ),
                    )
                    .toList()),
          )
      ]),
    );
  }
}
