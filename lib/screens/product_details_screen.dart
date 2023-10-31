import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = "/product-details";
  late String? title;
  late String? id;
  @override
  Widget build(BuildContext context) {
    final routeArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, String?>?;

    title = routeArguments?["title"];
    id = routeArguments?["id"];

    final productsData = Provider.of<Products_Provider>(context, listen: true);
    // listen: true using this means the change in ProductProvider must be reflected.It can be made false if you dont / only need one time update
    final loadedProduct = productsData.findById(
        id!); //method is hiiden in ProductProvider file  from acessing using productData we rhen call findById

    return Scaffold(
        appBar: AppBar(title: Text(loadedProduct.title)),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              // padding: EdgeInsets.all(8),
              // decoration: BoxDecoration(
              // color: Colors.black12,
              // borderRadius: BorderRadius.circular(45),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.blueGrey[300]!,
              //     blurRadius: 0,
              //   )
              // ]),
              margin: EdgeInsets.only(top: 0, left: 0, right: 0),
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40)),
                  child: Image.network(loadedProduct.imageUrl)),
            ),
            SizedBox(height: 5),
            Text(
              "₹ ${loadedProduct.price} ",
              style: GoogleFonts.abel(color: Colors.grey[600], fontSize: 40),
            ),
            SizedBox(height: 0),
            Container(
                child: FittedBox(
              child: Text(
                loadedProduct.title,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            )),
            SizedBox(height: 5),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: FittedBox(
                  child: Text(
                    loadedProduct.description,
                    softWrap: true,
                    style:
                        GoogleFonts.andika(fontSize: 15, color: Colors.black54),
                  ),
                )),
          ]),
        ));
  }
}
