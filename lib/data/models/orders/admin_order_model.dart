import 'package:shop_market/data/models/orders/products_model.dart';

class AdminOrderModel {
  final int id;
  final int userId;
  final String date;
  final List<ProductsModel> products;

  AdminOrderModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.products
  });

  factory AdminOrderModel.fromJson(Map<String, dynamic> json) {
    return AdminOrderModel(
        id: json["id"] as int? ?? 0,
        userId: json["userId"] as int? ?? 0,
        date: json["date"] as String? ?? "",
      products: (json["products"] as List?)?.map((e) => ProductsModel.fromJson(e)).toList() ?? []
    );
  }
}
