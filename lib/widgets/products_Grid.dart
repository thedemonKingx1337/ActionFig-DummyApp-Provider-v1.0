import 'package:flutter/material.dart';
import '../providers/products_provider.dart';
import 'package:provider/provider.dart';
import 'product_Griditem.dart';

class ProductsGrid extends StatelessWidget {
  bool showOnlyFavorites_passed;
  ProductsGrid(this.showOnlyFavorites_passed);
  @override
  Widget build(BuildContext context) {
    // now watch the changes in whole products
    final productsData = Provider.of<Products_Provider>(context);
    final fetched_Products = showOnlyFavorites_passed
        ? productsData.favoriteItems
        : productsData.items;
    return GridView.builder(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
        itemCount: fetched_Products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 7,
            crossAxisSpacing: 25,
            mainAxisSpacing: 30),
        // alternative method insted of using builder method in ChangeNotifierProvider

        // itemBuilder: (context, index) => ChangeNotifierProvider(
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
              // create new provider for notifying the change in single product because each have a Favorite Botton.So watch fetched_Product[index] changes in each item

              // create: (context) => fetched_Products[index],

              value: fetched_Products[index],
              //alternative method for builder method

              //insted of using arguments now we can use the provider
              child: ProductItem(
                  // fetched_Product[index].id,
                  // fetched_Product[index].title,
                  // fetched_Product[index].imageUrl,
                  ),
            ));
  }
}
