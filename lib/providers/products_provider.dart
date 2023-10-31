import 'package:flutter/foundation.dart';
import '../models/product.dart';

class Products_Provider with ChangeNotifier {
  bool showFavoritesOnly = false;

  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Hrll Boy',
      description: 'Top-G for sale!',
      price: 29000.50,
      imageUrl:
          'https://i.pinimg.com/564x/af/c7/f7/afc7f7116534c794f63f3f0e3dadec46.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Guy',
      description: 'The Might Guy',
      price: 10000000,
      imageUrl:
          'https://i.pinimg.com/564x/dd/9f/be/dd9fbe6b7ffbf4ccc4dc54d8c3eb7264.jpg',
    ),
    Product(
      id: 'p3',
      title: 'The Tsunade',
      description: 'A nice pair of ( . Y  . )  ',
      price: 50000.99,
      imageUrl:
          'https://i.pinimg.com/564x/81/06/0d/81060d34fe85bdebae675c71ee2df6aa.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Itachi',
      description: 'The Uchiha Itachi',
      price: 8499.99,
      imageUrl:
          'https://i.pinimg.com/564x/16/21/99/162199ecc7f7df73b5caa4d82562722a.jpg',
    ),
    Product(
      id: 'p5',
      title: 'OWNER',
      description: 'Jobless Highly Skilled Young Guy',
      price: 666666.66,
      imageUrl:
          'https://i.pinimg.com/564x/0c/01/d4/0c01d4f1511e34117d55625c67ada8fa.jpg',
    ),
    Product(
      id: 'p6',
      title: 'Madara',
      description: 'The Uchiha Madara',
      price: 140000.99,
      imageUrl:
          'https://i.pinimg.com/564x/e8/f6/fe/e8f6fe7410a0e544dc098b6a6942aa31.jpg',
    ),
    Product(
      id: 'p7',
      title: 'Gaara',
      description: 'Gaara of the desert',
      price: 140000.99,
      imageUrl:
          'https://i.pinimg.com/564x/b1/c6/37/b1c637f82df125b8bd27dce818c990aa.jpg',
    ),
  ];

  List<Product> get items {
    // if we use this kind of filtration every screen using provider will have the filter applied products

    // if (showFavoritesOnly) {
    //   return _items.where((element) => element.isFavorite).toList();
    // }

    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items
        .where((product_element) => product_element.isFavorite)
        .toList();
  }

  Product findById(String id) {
    return _items.firstWhere(
        (iterated_productElement) => iterated_productElement.id == id);
  }

// we dont use this method which effects all the screens

  // void toggleShow_FavoritesOnly() {
  //   showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void toggle_ShowAll() {
  //   showFavoritesOnly = false;
  //   notifyListeners();
  // }
  void addProduct(Product product) {
    final newProduct = Product(
        id: DateTime.now().toString(),
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl);
    _items.add(newProduct);

    // _items.insert(0, newProduct);     // alternative method to inserting at the begning

    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print("...");
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
