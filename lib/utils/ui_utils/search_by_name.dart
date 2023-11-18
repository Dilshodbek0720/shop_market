import 'package:shop_market/data/models/products/product_model.dart';

List<ProductModel> searchByName(List<ProductModel> models, String query) {
  List<ProductModel> results = [];

  for (ProductModel model in models) {
    if (model.title.toLowerCase().contains(query.toLowerCase())) {
      results.add(model);
    }
  }
  return results;
}