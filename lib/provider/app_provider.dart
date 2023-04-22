import 'package:den_ecommerce/model/cart_model.dart';
import 'package:den_ecommerce/provider/product_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../core/service_locator.dart';
import '../model/product_cart_model.dart';
import '../model/product_model.dart';
import '../model/user_model.dart';
import '../repository/repository.dart';

class AppProvider with ChangeNotifier {
  UserModel? _registerUser;

  UserModel? get registerUser => _registerUser;

  AuthUserModel? _currentUser;

  AuthUserModel? get currentUser => _currentUser;

//addto cart
  CartModel? _cart;

  CartModel? get cart => _cart;

  //get Product Cart

  List<CartModel>? _productCart;

  List<CartModel>? get productCart => _productCart;

  //productCartttDummy

  List<ProductCartModel>? _dummyList;

  List<ProductCartModel>? get dummyList => _dummyList;

  Future<void> getDummyProdcutCart({
    required int id,
    // required CartModel element,
    // required ProductModel productModel,
    required List<CartModel> productCartLst,
  }) async {
    try {
      print("id::$id");

      print("productCartLst::::${productCartLst.length}");
      // print("element ${element.product}");
      // print("productModel ${productModel.productId}");
      List<ProductCartModel> pCLists = [];

      // // ProductModel product = locator<ProductProvider>().product!;
      // ProductCartModel dummyProdcutCart = ProductCartModel(
      //   user: id,
      //   product: productModel,
      //   quantity: element.product,
      // );

      // pCList.add(dummyProdcutCart);

      // print("pClistlen:: $pCList");
      // print('whyyyy');
      // print(dummyProdcutCart.product.productName);
      // print('whyyyy');
      // pCList.add(dummyProdcutCart);
      // print('whattttt');
      // print(pCList.length);
      // print('whattttt');
      // _dummyList!.addAll(pCList);

      // print(":::::::::::");
      // print(_dummyList!.length);
      // print(":::::::::::");

      productCartLst.forEach((element) async {
        await locator<ProductProvider>().getProductDetail(id: element.product);

        ProductModel product = locator<ProductProvider>().product!;
        ProductCartModel dummyProdcutCart = ProductCartModel(
          user: id,
          product: product,
          quantity: element.product,
        );
        // print('whyyyy');
        // print(dummyProdcutCart.product.productName);
        // print('whyyyy');
        pCLists.add(dummyProdcutCart);
        print('whattttt');
        print(pCLists.length);
        print('whattttt');
      });
      print('pClist:: ${pCLists.length}');

      _dummyList = pCLists;
      notifyListeners();

      print("_dummyList :: ${_dummyList!.length}");
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> getProductCart({
    required int userId,
  }) async {
    try {
      // print("email: $username");
      // print("password: $password");

      final Response response = await Repository.getProductCart(
        userId: userId,
      );
      // print("::::::::::::::");
      // print(response.data);
      // print("::::::::::::::");
      // _productCart = CartModel.fromMap(response.data);
      if (response.data != null) {
        List list = response.data;
        List<CartModel> products = [];
        list.forEach((element) {
          products.add(CartModel.fromMap(element));
        });
        _productCart = products;

        print('getproductss');
        print(_productCart!.length);
        print('getproductss');
      }
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> addToCart({
    required int userId,
    required int productId,
  }) async {
    try {
      // print("email: $username");
      // print("password: $password");

      final Response response = await Repository.addTocart(
        userId: userId,
        productId: productId,
      );
      // print("::::::::::::::");
      // print(response.data);
      // print("::::::::::::::");
      _cart = CartModel.fromMap(response.data);
      print(":::::::::::::::");
      print(_cart);
      print(":::::::::::::::");
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    try {
      // print("email: $username");
      // print("password: $password");

      final Response response = await Repository.userLogin(
        password: password,
        username: username,
      );
      // print("::::::::::::::");
      // print(response.data);
      // print("::::::::::::::");
      _currentUser = AuthUserModel.fromMap(response.data);

      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> register({
    required String username,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String location,
    required String phoneNumber,
  }) async {
    try {
      // print('::::::::::::::::');
      // print('username: $username');
      // print('email: $email');
      // print('password: $password');
      // print('passwordConfrim: $password');
      // // print('gender: $gender');
      // // print('dob: $dob');
      // print('::::::::::::::::');
      final Response response = await Repository.userRegister(
        username: username,
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        location: location,
        phoneNumber: phoneNumber,
      );
      _registerUser = UserModel.fromMap(response.data);

      // print("::::::::::::::");
      // print(response.data);
      // print("::::::::::::::");
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}




//  cart scren = 
 
//  - products list
//  - Confrim Order

//  - dialog box( Grand TOatl, delivery option, confirm order),

//  - My orderHistory :



// [
//   {
//   orderID:1,
//   userID:1, 
//   productList: [],
//   GrandTOtal: 
// },
// {
//   orderID:2,
//   userID:1, 
//   productList: [],
//   GrandTOtal: 
// }
// ]