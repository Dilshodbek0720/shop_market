import 'package:shop_market/data/models/products/product_model.dart';
import 'package:shop_market/data/models/universal_data.dart';
import 'package:shop_market/services/api_service.dart';

class ProductRepository{
  final ApiService apiService;

  ProductRepository({required this.apiService});

  Future<UniversalData> getAllProducts() async =>
      await apiService.getAllProducts();

  Future<UniversalData> getProductsByLimit({required int limitCount}) async =>
      await apiService.getProductsByLimit(limitCount: limitCount);

  Future<UniversalData> getProductById({required int productId}) async =>
      await apiService.getProductById(productId: productId);

  Future<UniversalData> addProduct({required ProductModel productModel}) async =>
      await apiService.addProduct(productModel: productModel);

  Future<UniversalData> getCategoryProducts({required String categoryName}) async =>
      await apiService.getCategoryProducts(categoryName: categoryName);

  Future<UniversalData> getAllCategoriesProducts() async =>
      await apiService.getAllCategoryProducts();
}