import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});
}

class Cart with ChangeNotifier {
  late Map<String, CartItem> items = {};
  Map<String, CartItem> get items_in_cart {
    return {...items};
    //will provide a copy of new Map the items in cart having a key value pair
  }

  void addItem_To_Cart(String productId, double price, String title) {
    if (items.containsKey(productId)) {
      items.update(
          productId,
          (existingCartItem_fromTheKey) => CartItem(
                id: existingCartItem_fromTheKey.id,
                title: existingCartItem_fromTheKey.title,
                price: existingCartItem_fromTheKey.price,
                quantity: existingCartItem_fromTheKey.quantity + 1,
              ));
    } else {
      items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          quantity: 1,
          price: price,
        ),
      );
    }
    notifyListeners();
  }

  void subtractItemInCart(String productId) {
    if (!items.containsKey(productId)) {
      return;
    }
    // if (items.containsKey(productId)) {
    if (items[productId]!.quantity > 1) {
      items.update(
        productId,
        (existingCartItemFromTheKey) => CartItem(
          id: existingCartItemFromTheKey.id,
          title: existingCartItemFromTheKey.title,
          price: existingCartItemFromTheKey.price,
          quantity: existingCartItemFromTheKey.quantity - 1,
        ),
      );
    } else {
      // If the quantity is already 0 or less,remove the item from the cart.

      items.remove(productId);
    }
    // } else {
    //   // Handle the case where the product is not in the cart if needed.
    // }

    notifyListeners();
  }

  int get itemCountInCart {
    return items == 0 ? 0 : items.length;
  }

  double get totalAmount {
    double total = 0.0;
    items.forEach((key, IteratedElement_value) {
      total += IteratedElement_value.price * IteratedElement_value.quantity;
    });
    return total;
  }

  void removeItem(String productid_passed) {
    items.remove(productid_passed);
    notifyListeners();
  }

  void clearCart() {
    items = {};
    notifyListeners();
  }
}
