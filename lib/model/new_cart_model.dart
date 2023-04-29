class NewCartModel {
  final int id;
  final int user;
  final Product product;
  final int quantity;

  NewCartModel({
    required this.id,
    required this.user,
    required this.product,
    required this.quantity,
  });

  factory NewCartModel.fromMap(Map<String, dynamic> json) => NewCartModel(
        id: json["id"],
        user: json["user"],
        product: Product.fromMap(json["product"]),
        quantity: json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user": user,
        "product": product.toMap(),
        "quantity": quantity,
      };
}

class Product {
  final int productId;
  final String productName;
  final String price;
  final String description;
  final String specification;
  final String image;
  final int category;

  Product({
    required this.productId,
    required this.productName,
    required this.price,
    required this.description,
    required this.specification,
    required this.image,
    required this.category,
  });

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        productId: json["product_id"],
        productName: json["product_name"],
        price: json["price"],
        description: json["description"],
        specification: json["specification"],
        image: json["image"],
        category: json["category"],
      );

  Map<String, dynamic> toMap() => {
        "product_id": productId,
        "product_name": productName,
        "price": price,
        "description": description,
        "specification": specification,
        "image": image,
        "category": category,
      };
}
