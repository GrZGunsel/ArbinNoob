import 'package:den_ecommerce/model/product_model.dart';
import 'package:flutter/material.dart';

import '../model/cart_model.dart';

class OrderProvider with ChangeNotifier {
  List<ProductModel> _productList = [];

  List<ProductModel> get productList => _productList;

  addProductToCart({
    required List<ProductModel> product,
  }) async {
    List<ProductModel> list = [];
    print(".......cart list");
    print(product.length);
    print("cart list.......");
    notifyListeners();

    list.addAll(product);
    list.forEach((element) {
      print(element.productName);
    });
    _productList = list;
  }
}
