class ProductModel {
  ProductModel({
    required this.productId,
    required this.productName,
    required this.price,
    required this.description,
    required this.specification,
    required this.image,
    required this.category,
  });

  final int productId;
  final String productName;
  final String price;
  final String description;
  final String specification;
  final String image;
  final int category;

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
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


