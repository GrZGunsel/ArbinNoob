import 'package:dio/dio.dart';

import '../core/api_manager.dart';
import '../core/service_locator.dart';

class Repository {
  static final _apiManager = locator<ApiManager>();

  static String loginUrl = 'login/';
  static String registerUrl = 'register/';
  static String addToCartUrl = 'cart/';
  static String cartListUrl = 'carts';

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
