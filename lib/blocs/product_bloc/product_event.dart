part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class GetProductsEvent extends ProductEvent {}

class AddProductEvent extends ProductEvent {
  final ProductModel productModel;

  AddProductEvent({required this.productModel});
}

class UpdateProductEvent extends ProductEvent {
  final ProductModel productModel;

  UpdateProductEvent({required this.productModel});
}

class DeleteProductEvent extends ProductEvent {
  final int productId;

  DeleteProductEvent({required this.productId});
}
class GetProductByIdEvent extends ProductEvent {
  final int productId;

  GetProductByIdEvent({required this.productId});
}

class GetCategoryProductsEvent extends ProductEvent{
  final String categoryName;

  GetCategoryProductsEvent({required this.categoryName});
}