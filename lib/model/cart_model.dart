class CartModel {
  CartModel({
    required this.user,
    required this.product,
    required this.quantity,
  });

  final int user;
  final int product;
  final int quantity;

  factory CartModel.fromMap(Map<String, dynamic> json) => CartModel(
        user: json["user"],
        product: json["product"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "user": user,
        "product": product,
        "quantity": quantity,
      };
}
