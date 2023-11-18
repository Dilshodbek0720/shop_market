class ProductsModel {
  final int productId;
  final int quantity;

  ProductsModel({required this.productId, required this.quantity});

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      productId: json['productId'] as int? ?? 0,
      quantity: json['quantity'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "productId":productId,
      "quantity":quantity
    };
  }
}
