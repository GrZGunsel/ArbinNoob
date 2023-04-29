import 'package:den_ecommerce/model/order_model.dart';
import 'package:dio/dio.dart';

import '../core/api_manager.dart';
import '../core/service_locator.dart';

class Repository {
  static final _apiManager = locator<ApiManager>();

  static String loginUrl = 'login/';
  static String registerUrl = 'register/';
  static String addToCartUrl = 'cart/';
  static String cartListUrl = 'carts';
  static String userDetailUrl = 'users';
  static String orderUrl = "orders/";

  static Future<Response> order({
    required String deliveryAddress,
    required bool isPaid,
    required String deliveryOption,
    required List products,
    required int user,
  }) async {
    print("::::::repo::111:::::");
    print("deliveryAddress::$deliveryAddress");
    print("isPaid::$isPaid");
    print("deliveryOption::$deliveryOption");
    print("products1::${products[0].product}");
    print("products1::${products[0].quantity}");
    print("products2::${products[1].product}");
    print("products2::${products[1].quantity}");
    print("user::$user");
    print("::::::repo:::222::::");

    print(_apiManager.dio.post(orderUrl, data: {
      "delivery_address": deliveryAddress,
      "is_paid": isPaid,
      "delivery_option": deliveryOption,
      "products": [
        {"product": 1, "quantity": 2},
        {"product": 2, "quantity": 1}
      ],
      "user": user,
    }));

    return _apiManager.dio.post(orderUrl, data: {
      "delivery_address": deliveryAddress,
      "is_paid": isPaid,
      "delivery_option": deliveryOption,
      "products": products,
      "user": user,
    });
  }

  static Future<Response> getUserDetails({
    required int userId,
  }) async {
    return _apiManager.dio.get('$userDetailUrl/$userId/');
  }

  static Future<Response> getProductCart({
    required int userId,
  }) async {
    return _apiManager.dio.get('$cartListUrl/$userId/');
  }

  static Future<Response> addTocart({
    required int userId,
    required int productId,
    // required String password,
  }) async {
    return _apiManager.dio.post(addToCartUrl, data: {
      "user": userId,
      "product": productId,
      // "quantity": 1,
    });
  }

  static Future<Response> userLogin({
    required String username,
    required String password,
  }) async {
    return _apiManager.dio.post(loginUrl, data: {
      "username": username,
      "password": password,
    });
  }

  static Future<Response> userRegister({
    required String username,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String location,
    required String phoneNumber,
  }) async {
    // print({
    //   "name": name,
    //   "email": email,
    //   "password": password,
    //   "password_confirmation": passwordConfirmation,
    //   "gender": gender,
    //   "dob": dob,
    // });
    var response = _apiManager.dio.post(
      registerUrl,
      data: {
        "username": username,
        "email": email,
        "password": password,
        "first_name": firstName,
        "last_name": lastName,
        "location": location,
        "phone_number": phoneNumber,
      },
    );
    return response;
  }
}
