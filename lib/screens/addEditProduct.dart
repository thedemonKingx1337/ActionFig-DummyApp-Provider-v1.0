import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/products_provider.dart';

class AddEditUserProductScreen extends StatefulWidget {
  static const routeName = "/addEditUserProduct";

  @override
  State<AddEditUserProductScreen> createState() =>
      _AddEditUserProductScreenState();
}

class _AddEditUserProductScreenState extends State<AddEditUserProductScreen> {
  final descriptionFocusNode = FocusNode();
  final imageUrlFocusNode = FocusNode();
  final imageUrlController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var editedProduct =
      Product(id: null, title: "", description: "", price: 0, imageUrl: "");

  var initvalues = {
    "title": "",
    "description": "",
    "price": "",
    "imageUrl": ""
  };

  var isInit = true;

  @override
  void initState() {
    imageUrlFocusNode.addListener(updateImageUrlFocusFunction);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String?;

      if (productId != null) {
        final productLoaded =
            Provider.of<Products_Provider>(context, listen: false)
                .findById(productId);

        editedProduct = productLoaded;

        initvalues = {
          "title": editedProduct.title,
          "description": editedProduct.description,
          "price": editedProduct.price.toString(),
          // "imageUrl": editedProduct.imageUrl,
        };
        imageUrlController.text = editedProduct.imageUrl;
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    descriptionFocusNode.dispose();
    imageUrlFocusNode.dispose();
    imageUrlController.dispose();
    imageUrlFocusNode.removeListener(updateImageUrlFocusFunction);
    super.dispose();
  }

  void updateImageUrlFocusFunction() {
    if (!imageUrlFocusNode.hasFocus) {
      if ((!imageUrlController.text.startsWith("http://") &&
              !imageUrlController.text.startsWith("https://")) ||
          (!imageUrlController.text.endsWith(".jpeg") &&
              !imageUrlController.text.endsWith(".png") &&
              !imageUrlController.text.endsWith(".jpg"))) {
        return;
      }
      setState(() {});
    }
  }

  void saveForm() {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
    if (editedProduct.id != null) {
      Provider.of<Products_Provider>(context, listen: false)
          .updateProduct(editedProduct.id!, editedProduct);
    } else {
      Provider.of<Products_Provider>(context, listen: false)
          .addProduct(editedProduct);
    }

    print(editedProduct.id);
    print(editedProduct.title);
    print(editedProduct.description);
    print(editedProduct.price);
    print(editedProduct.imageUrl);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: initvalues["title"],
                decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle: TextStyle(color: Colors.blueGrey),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) =>
                    FocusScope.of(context).requestFocus(descriptionFocusNode),
                onSaved: (value) {
                  editedProduct = Product(
                      id: editedProduct.id,
                      title: value!,
                      description: editedProduct.description,
                      price: editedProduct.price,
                      imageUrl: editedProduct.imageUrl,
                      isFavorite: editedProduct.isFavorite);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please provide a Title";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                initialValue: initvalues["description"],
                cursorColor: Colors.redAccent,
                decoration: InputDecoration(
                  labelText: "Description",
                  labelStyle: TextStyle(color: Colors.blueGrey),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                focusNode: descriptionFocusNode,
                onSaved: (value) {
                  editedProduct = Product(
                      id: editedProduct.id,
                      title: editedProduct.title,
                      description: value!,
                      price: editedProduct.price,
                      imageUrl: editedProduct.imageUrl,
                      isFavorite: editedProduct.isFavorite);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please provide a Discription";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                initialValue: initvalues["price"],
                cursorColor: Colors.redAccent,
                decoration: InputDecoration(
                  labelText: "Price",
                  labelStyle: TextStyle(color: Colors.blueGrey),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (value) =>
                    FocusScope.of(context).requestFocus(imageUrlFocusNode),
                onSaved: (value) {
                  editedProduct = Product(
                      id: editedProduct.id,
                      title: editedProduct.title,
                      description: editedProduct.description,
                      price: double.parse(value!),
                      imageUrl: editedProduct.imageUrl,
                      isFavorite: editedProduct.isFavorite);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please provide Price";
                  }
                  if (double.tryParse(value) == null) {
                    return "Please enter a valid number";
                  }
                  if (double.parse(value) < 0) {
                    return "price must be >= 0";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 5, color: Colors.white54),
                    ),
                    child: imageUrlController.text.isEmpty
                        ? Center(child: Text("Enter a\n  URL"))
                        : FittedBox(
                            child: Image.network(
                              imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: imageUrlController,
                      cursorColor: Colors.redAccent,
                      decoration: InputDecoration(
                        labelText: "Image Url",
                        labelStyle: TextStyle(color: Colors.blueGrey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.url,
                      focusNode: imageUrlFocusNode,
                      // onSaved: (value) => saveForm(),
                      onFieldSubmitted: (value) {
                        editedProduct = Product(
                            id: editedProduct.id,
                            title: editedProduct.title,
                            description: editedProduct.description,
                            price: editedProduct.price,
                            imageUrl: value,
                            isFavorite: editedProduct.isFavorite);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please provide a URL";
                        }
                        if (!value.startsWith("http://") &&
                            !value.startsWith("https://")) {
                          return "Please provide a valid URL";
                        }
                        if (!value.endsWith(".jpeg") &&
                            !value.endsWith(".png") &&
                            !value.endsWith(".jpg")) {
                          return "Please provide a valid URL";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              ElevatedButton(onPressed: saveForm, child: Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}
