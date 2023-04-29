import 'package:den_ecommerce/model/product_model.dart';
import 'package:den_ecommerce/repository/product_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> get productList => _products;

  ProductModel? _product;
  ProductModel? get product => _product;

  Future<void> getProduct() async {
    try {
      final Response response = await ProductRepository.getProducts();

      if (response.data != null) {
        List list = response.data;
        List<ProductModel> products = [];
        list.forEach((element) {
          products.add(ProductModel.fromMap(element));
          print("ourproduct::: ${products[0].productName}");
        });
        _products = products;
        print(":::::");
        print(_products);
        print(_products.length);
        print(":::::");
        notifyListeners();
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> getProductDetail({required int id}) async {
    try {
      final Response response =
          await ProductRepository.getProductsDetail(id: id);

      if (response.data != null) {
        _product = ProductModel.fromMap(response.data);
        print("::ppp:::");
        print(_product);
        // print(_products.length);
        print("::pp:::");
        notifyListeners();
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
