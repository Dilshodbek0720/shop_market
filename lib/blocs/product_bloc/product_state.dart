part of 'product_bloc.dart';

class ProductStates extends Equatable {
  final List<ProductModel> products;
  final ProductModel productModel;
  final FormStatus status;

  const ProductStates({
    required this.products,
    required this.productModel,
    required this.status,
  });

  @override
  List<Object?> get props => [
    productModel,
    status,
    products
  ];

  ProductStates copyWith({
    ProductModel? productModel,
    FormStatus? status,
    List<ProductModel>? products,
  }) {
    return ProductStates(
      productModel: productModel ?? this.productModel,
      status: status ?? this.status,
      products: products ?? this.products,
    );
  }
}