import 'package:flutter/material.dart';
import 'providers/orders.dart';
import 'screens/addEditProduct.dart';
import 'screens/cartScreen.dart';
import 'screens/orderScreen.dart';
import 'screens/user_productsScreen.dart';
import 'providers/cart.dart';
import 'providers/products_provider.dart';
import 'screens/product_details_screen.dart';
import 'package:provider/provider.dart';
import 'screens/product_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //in main file don't user ChangeNotifierProvider.value method use builder method to avoid bugs
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Products_Provider()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => Orders())
      ],
      child: MaterialApp(
        title: 'DeliMeals',
        theme: ThemeData(
            fontFamily: "Lato",
            primarySwatch: Colors.deepOrange,
            canvasColor: Colors.blueGrey[100]),
        home: MyHomePage(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routName: (context) => CartScreen(),
          OrderScreen.routName: (context) => OrderScreen(),
          UserProductScreen.routeName: (context) => UserProductScreen(),
          AddEditUserProductScreen.routeName: (context) =>
              AddEditUserProductScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ProductOverviewScreen();
  }
}
