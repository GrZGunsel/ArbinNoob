// To parse this JSON data, do
//
//     final orderModel = orderModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OrderModel orderModelFromMap(String str) =>
    OrderModel.fromMap(json.decode(str));

String orderModelToMap(OrderModel data) => json.encode(data.toMap());

OrderProduct orderProductModelFromMap(String str) =>
    OrderProduct.fromMap(json.decode(str));

String orderProductModelToMap(OrderProduct data) => json.encode(data.toMap());

class OrderModel {
  final int id;
  final String deliveryAddress;
  final bool isPaid;
  final String deliveryOption;
  final int user;
  final List<OrderProduct> products;

  OrderModel({
    required this.id,
    required this.deliveryAddress,
    required this.isPaid,
    required this.deliveryOption,
    required this.user,
    required this.products,
  });

  factory OrderModel.fromMap(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        deliveryAddress: json["delivery_address"],
        isPaid: json["is_paid"],
        deliveryOption: json["delivery_option"],
        user: json["user"],
        products: List<OrderProduct>.from(
            json["products"].map((x) => OrderProduct.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "delivery_address": deliveryAddress,
        "is_paid": isPaid,
        "delivery_option": deliveryOption,
        "user": user,
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
      };
}

class OrderProduct {
  final int product;
  final int quantity;

  OrderProduct({
    required this.product,
    required this.quantity,
  });

  factory OrderProduct.fromMap(Map<String, dynamic> json) => OrderProduct(
        product: json["product"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "product": product,
        "quantity": quantity,
      };
}
