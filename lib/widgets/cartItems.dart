import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String productId;
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(this.productId, this.id, this.title, this.quantity, this.price);

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context, listen: false);
    return Consumer<Cart>(builder: (context, value, child) {
      return Dismissible(
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(right: 30),
          child: Icon(
            Icons.delete,
            size: 40,
            color: Colors.red,
          ),
        ),
        key: ValueKey(id),
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ListTile(
                leading: Chip(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  label: FittedBox(child: Text("₹${price} / ps")),
                ),
                title: Text(title),
                subtitle:
                    Text(" total : ₹${(quantity * price).toStringAsFixed(2)}"),
                trailing: IntrinsicWidth(
                  child: Row(
                    children: [
                      Text("X ${quantity}"),
                      IconButton(
                          onPressed: () {
                            cartData.subtractItemInCart(productId);
                          },
                          icon: Icon(Icons.remove))
                    ],
                  ),
                )),
          ),
        ),
        onDismissed: (direction) {
          cartData.removeItem(productId);
        },
        confirmDismiss: (direction) {
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("കഷ്ടപ്പെട്ട് Add ആക്കിയിട്ട് കളയണോ മൈരേ ! !"),
                content: Text("are you sure??"),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text("Yes")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text("No")),
                ],
              );
            },
          );
        },
      );
    });
  }
}
