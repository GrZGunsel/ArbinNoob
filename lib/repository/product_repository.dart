import 'package:dio/dio.dart';

import '../core/api_manager.dart';
import '../core/service_locator.dart';

class ProductRepository {
  static final _apiManager = locator<ApiManager>();

  static Future<Response> getProducts() async {
    return _apiManager.dio.get('products/');
  }

  static Future<Response> getProductsDetail({required int id}) async {
    return _apiManager.dio.get('products/$id/');
  }
}
