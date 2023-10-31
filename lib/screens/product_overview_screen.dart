import 'package:flutter/material.dart';
import '../providers/cart.dart';
import 'cartScreen.dart';
import '../widgets/cartBadge.dart';
import '../widgets/mainDrawer.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../widgets/products_Grid.dart';

enum FilterOption {
  Favorites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    //using this method will effect all screen using the products becouse of the filtering done on provider
    final productsData = Provider.of<Products_Provider>(context);
    final products = productsData.items;

    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        elevation: 0,
        title: Text("Action-figgy"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    CheckedPopupMenuItem(
                      child: Text("favorites"),
                      value: FilterOption.Favorites,
                    ),
                    CheckedPopupMenuItem(
                      child: Text("All Items"),
                      value: FilterOption.All,
                    ),
                  ],
              onSelected: (FilterOption Selected_filter) {
                setState(() {
                  if (Selected_filter == FilterOption.Favorites) {
                    //using this method will effect all screen using the products becouse of the filtering done on provider

                    // productsData.toggleShow_FavoritesOnly();

                    //use this satful method to manage filter for a single screen
                    showOnlyFavorites = true;
                  } else {
                    // productsData.toggle_ShowAll();

                    showOnlyFavorites = false;
                  }
                });
              }),
          Consumer<Cart>(
            builder: (context, cartData, consumer_child) => Padding(
              padding: const EdgeInsets.only(right: 5),
              child: CartBadge(
                  value: cartData.itemCountInCart.toString(),
                  child: consumer_child!),
            ),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routName);
                },
                icon: Icon(Icons.shopping_cart)),
          )
        ],
      ),
      body: ProductsGrid(showOnlyFavorites),
    );
  }
}
