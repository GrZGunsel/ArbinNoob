import 'package:den_ecommerce/model/cart_model.dart';
import 'package:den_ecommerce/model/order_model.dart';
import 'package:den_ecommerce/provider/product_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../core/service_locator.dart';
import '../model/new_cart_model.dart';
import '../model/product_cart_model.dart';
import '../model/product_model.dart';
import '../model/user_model.dart';
import '../repository/repository.dart';

class AppProvider with ChangeNotifier {
  UserDetailModel? _userDetail;

  UserDetailModel? get userDetail => _userDetail;

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

  //new cart screen
  List<NewCartModel>? _newProductCart;

  List<NewCartModel>? get newProductCart => _newProductCart;

  //counter
  int _counter = 0;

  // int get counter => _counter;

// int get counter{
//   return
// }

///////order/////
  OrderModel? _orderModel;
  OrderModel? get orderModel => _orderModel;

  Future<void> order({
    required String deliveryAddress,
    required bool isPaid,
    required String deliveryOption,
    required List products,
    required int user,
  }) async {
    try {
      // print("email: $username");
      // print("password: $password");
      print('sucess');

      print("deliveryAddress::$deliveryAddress");
      print("isPaid::$isPaid");
      print("deliveryOption::$deliveryOption");
      print("products::${products}");
      print("user::$user");
      final Response response = await Repository.order(
        deliveryAddress: deliveryAddress,
        isPaid: isPaid,
        deliveryOption: deliveryOption,
        products: products,
        user: user,
      );

      if (response.data != null) {
        print("data11:::");
        print(response.data);
        print("data22:::");
        _orderModel = OrderModel.fromMap(response.data);

        // print("_orderModel::${_orderModel!.products.length}");
      }

      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> getUserDetail({
    required int userId,
  }) async {
    try {
      print("userID:::::::;;;$userId");
      final Response response = await Repository.getUserDetails(
        userId: userId,
      );
      if (response.data != null) {
        // UserDetailModel user = response.data;
        _userDetail = UserDetailModel.fromMap(response.data);
        print(_userDetail);
        print("User::${_userDetail!.firstName}");
      }
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  set counter(int value) {
    //print("valuebe: $value");
    value++;
    _counter = value;
    // print("valueaft: $value");
    // print("_counter: $_counter");
    notifyListeners();
  }

  increment(index) {
    counter = newProductCart![index].quantity;
  }

  // set setquantityValueDec(int value) {
  //   value--;
  // }

  Future<void> getDummyProdcutCart({
    required int id,
    // required CartModel element,
    // required ProductModel productModel,
    required List<CartModel> productCartLst,
  }) async {
    try {
      // print("id::$id");

      // print("productCartLst::::${productCartLst.length}");
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
        // print('whattttt');
        // print(pCLists.length);
        // print('whattttt');
      });
      //print('pClist:: ${pCLists.length}');

      _dummyList = pCLists;
      notifyListeners();

      //print("_dummyList :: ${_dummyList!.length}");
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
      // print("userId $userId");
      final Response response = await Repository.getProductCart(
        userId: userId,
      );
      // print("::::::::::::::");
      // print(response.data);
      // print("::::::::::::::");
      // _productCart = CartModel.fromMap(response.data);
      if (response.data != null) {
        List list = response.data;
        List<NewCartModel> products = [];
        list.forEach((element) {
          //print("element:: $element");
          products.add(NewCartModel.fromMap(element));
        });
        // print(products.length);
        _newProductCart = products;

        //print("_newProductCart!.length:: ${_newProductCart!.length}");
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
      // print(":::::::::::::::");
      // print(_cart);
      // print(":::::::::::::::");
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> updateCart({
    required int user,
    required int product,
    required int quantity,
    required int cartId,
  }) async {
    print("user $user");
    print("product $product");
    print("quantity $quantity");
    print("cartID $cartId");
    try {
      final Response response = await Repository.updateCart(
        user: user,
        product: product,
        quantity: quantity,
        cartId: cartId,
      );

      print("::::::update cart::::::::");
      print(response.data);
      print("::::::update cart::::::::");
      // _cart = CartModel.fromMap(response.data);
      // print(":::::::::::::::");
      // print(_cart);
      // print(":::::::::::::::");
      await getProductCart(userId: user);
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
      print("email: $username");
      print("password: $password");

      final Response response = await Repository.userLogin(
        password: password,
        username: username,
      );
      print("::::::::::::::");
      print(response.data);
      print("::::::::::::::");
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
