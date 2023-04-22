import 'package:den_ecommerce/model/product_model.dart';

class ProductCartModel {
  final int user;
  final ProductModel product;
  final int quantity;

  ProductCartModel({
    required this.user,
    required this.product,
    required this.quantity,
  });
}
