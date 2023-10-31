import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/product.dart';
import '../screens/product_details_screen.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  // final String passed_Id;
  // final String title;
  // final String imageUrl;
  // ProductItem(this.passed_Id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    //now watch changes in the single Product using the provider
    final product_Data = Provider.of<Product>(context, listen: false);
    final cartData = Provider.of<Cart>(context, listen: false);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.2), // Shadow color
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(2, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
        child: GridTile(
          child: InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(ProductDetailScreen.routeName, arguments: {
                "id": product_Data.id,
                "title": product_Data.title,
              });
            },
            child: Image.network(
              product_Data.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            //wraping the only changing part with consumer so only the changing favorite part get re-rendered insted of the whole Product part
            //consumer is now listeing to Product
            leading: Consumer<Product>(
              builder: (context, value, child) => IconButton(
                onPressed: () => product_Data.toggleFavoriteStatus(),
                icon: product_Data.isFavorite
                    ? Icon(FontAwesomeIcons.solidHeart, color: Colors.red)
                    : Icon(FontAwesomeIcons.heart, color: Colors.redAccent),
              ),
            ),
            title: Text(product_Data.title),
            trailing: IconButton(
              onPressed: () {
                cartData.addItem_To_Cart(
                    product_Data.id!, product_Data.price, product_Data.title);
                // show frequently coming Snackbar one after another without the time delay
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Item Added to Cart",
                    // textAlign: TextAlign.center
                  ),
                  duration: Duration(seconds: 3),
                  action: SnackBarAction(
                      label: "UNDO",
                      onPressed: () {
                        cartData.subtractItemInCart(product_Data.id!);
                      }),
                ));
              },
              icon: Icon(FontAwesomeIcons.shoppingCart, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
