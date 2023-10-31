import 'package:flutter/material.dart';
import 'addEditProduct.dart';
import '../widgets/userProduct_items.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = "/userProductScreen";

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products_Provider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Products"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AddEditUserProductScreen.routeName);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (context, index) => Column(
            children: [
              UserProductItem(
                  productsData.items[index].id!,
                  productsData.items[index].title,
                  productsData.items[index].imageUrl),
              Divider()
            ],
          ),
        ),
      ),
    );
  }
}
