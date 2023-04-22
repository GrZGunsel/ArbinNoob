import 'package:den_ecommerce/model/product_model.dart';

class CartModel {
  final ProductModel product;
  final double totalPrice;
  final double quantity;

  CartModel({
    required this.product,
    required this.totalPrice,
    required this.quantity,
  });
}
