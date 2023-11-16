import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_market/data/models/products/product_model.dart';
import 'package:shop_market/data/models/products/rating_model.dart';
import 'package:shop_market/data/repository/product_repository.dart';
import '../../data/models/status/form_status.dart';
import '../../data/models/universal_data.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductStates> {

  ProductBloc({required this.productRepository})
      : super(
    ProductStates(
      products: const [],
      productModel: ProductModel(
        title: '',
        id: 0,
        description: '',
        price: 0,
        image: '',
        category: '',
        ratingModel: RatingModel(count: 0,rate: 0),
      ),
      status: FormStatus.pure,
    ),
  ) {
    on<GetProductsEvent>(getAllProducts);
    on<GetProductByIdEvent>(getByIdProduct);
    on<AddProductEvent>(addProduct);
    on<UpdateProductEvent>(updateProduct);
    on<DeleteProductEvent>(deleteProduct);
    on<GetCategoryProductsEvent>(getCategoryProducts);
  }

  final ProductRepository productRepository;

  Future<void> getAllProducts(
      GetProductsEvent event, Emitter<ProductStates> emit) async {
    emit(state.copyWith(status: FormStatus.loading));
    UniversalData response = await productRepository.getAllProducts();

    if (response.error.isEmpty) {
      print(response.data);
      emit(state.copyWith(
          status: FormStatus.success,
          products: response.data as List<ProductModel>
      ));
    } else {
      emit(state.copyWith(
        status: FormStatus.failure,
      ));
    }

  }

  Future<void> getCategoryProducts(
      GetCategoryProductsEvent event, Emitter<ProductStates> emit) async {
    emit(state.copyWith(status: FormStatus.loading));
    UniversalData response = await productRepository.getCategoryProducts(categoryName: event.categoryName);

    if (response.error.isEmpty) {
      emit(state.copyWith(
          status: FormStatus.success,
          products: response.data as List<ProductModel>
      ));
    } else {
      emit(state.copyWith(
        status: FormStatus.failure,
      ));
    }

  }

  Future<void> getByIdProduct(
      GetProductByIdEvent event, Emitter<ProductStates> emit) async {
    emit(state.copyWith(status: FormStatus.loading));

    if (true) {
      emit(state.copyWith(
        status: FormStatus.success,
      ));
    }

    emit(state.copyWith(
      status: FormStatus.failure,
    ));
  }


  Future<void> addProduct(
      AddProductEvent event, Emitter<ProductStates> emit) async {
    emit(state.copyWith(status: FormStatus.loading));

    if (true) {
      emit(state.copyWith(
        status: FormStatus.success,
      ));
    }

    emit(state.copyWith(
      status: FormStatus.failure,
    ));
  }


  Future<void> updateProduct(
      UpdateProductEvent event, Emitter<ProductStates> emit) async {

    emit(state.copyWith(status: FormStatus.loading));

    if (true) {
      emit(state.copyWith(
        status: FormStatus.success,
      ));
    }

    emit(state.copyWith(
      status: FormStatus.failure,
    ));
  }

  Future<void> deleteProduct(
      DeleteProductEvent event, Emitter<ProductStates> emit) async{

    emit(state.copyWith(status: FormStatus.loading));

    if (true) {
      emit(state.copyWith(
        status: FormStatus.success,
      ));
    }

    emit(state.copyWith(
      status: FormStatus.failure,
    ));
  }

}