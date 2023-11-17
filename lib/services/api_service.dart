import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_market/data/models/products/product_model.dart';
import 'package:shop_market/data/models/universal_data.dart';
import 'package:shop_market/utils/constants/constants.dart';

class ApiService {
  final _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {"Content-Type": "application/json"},
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    ),
  );

  ApiService() {
    init();
  }

  init() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          debugPrint('On Error: ${error.message}');

          return handler.next(error);
        },
        onRequest: (requestOptions, handler) async {
          debugPrint('On Request: ${requestOptions.data}');
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) async {
          debugPrint('On Response: ${response.statusCode}');
          debugPrint('PATH: ${response.requestOptions.path}');
          return handler.next(response);
        },
      ),
    );
  }

  // ---------------LOGIN------------------

  Future<UniversalData> loginUser({required String username, required String password}) async {
    try {
      final response = await _dio.post('/auth/login', data: {"username": username, "password": password});
      if (response.statusCode == 200) {
        return UniversalData(data: response.data['token']);
      }
      return UniversalData(error: "Error: ${response.statusCode}");
    } on DioException catch (e) {
      return UniversalData(error: "Dio Error: $e");
    } catch (e) {
      return UniversalData(error: e.toString());
    }
  }

  // ---------------PRODUCTS------------------

  Future<UniversalData> getAllProducts() async {
    Response response;
    try {
      response = await _dio.get("/products");
      if (response.statusCode == 200) {
        return UniversalData(
          data: (response.data as List?)
              ?.map((e) => ProductModel.fromJson(e))
              .toList() ??
              [],
        );
      }
      return UniversalData(error: "Error: ${response.statusCode}");
    }on DioException catch (e) {
      return UniversalData(error: "Dio Error: $e");
    } catch (e) {
      return UniversalData(error: e.toString());
    }
  }

  Future<UniversalData> getProductsByLimit({required int limitCount}) async {
    Response response;
    try {
      response = await _dio.get("/products?limit=$limitCount");
      if (response.statusCode == 200) {
        return UniversalData(
          data: (response.data as List?)
              ?.map((e) => ProductModel.fromJson(e))
              .toList() ??
              [],
        );
      }
      return UniversalData(error: "Error: ${response.statusCode}");
    }on DioException catch (e) {
      return UniversalData(error: "Dio Error: $e");
    } catch (e) {
      return UniversalData(error: e.toString());
    }
  }


  Future<UniversalData> getProductById({required int productId}) async {
    Response response;
    try {
      response = await _dio.get("/products/$productId");
      if (response.statusCode == 200) {
        return UniversalData(
          data: ProductModel.fromJson(response.data),
        );
      }
      return UniversalData(error: "Error: ${response.statusCode}");
    }on DioException catch (e) {
      return UniversalData(error: "Dio Error: $e");
    } catch (e) {
      return UniversalData(error: e.toString());
    }
  }

  Future<UniversalData> addProduct({required ProductModel productModel}) async {
    Response response;
    try {
      response = await _dio.post("/products", data: productModel.toJson());
      if (response.statusCode == 200) {
        return UniversalData(
          data: ProductModel.fromJson(response.data),
        );
      }
      return UniversalData(error: "Error: ${response.statusCode}");
    }on DioException catch (e) {
      return UniversalData(error: "Dio Error: $e");
    } catch (e) {
      return UniversalData(error: e.toString());
    }
  }

  Future<UniversalData> getCategoryProducts({required String categoryName}) async {
    Response response;
    try {
      response = await _dio.get(categoryName.isNotEmpty
          ? '/products/category/$categoryName'
          : "/products");
      if (response.statusCode == 200) {
        return UniversalData(
          data: (response.data as List?)
              ?.map((e) => ProductModel.fromJson(e))
              .toList() ??
              [],
        );
      }
      return UniversalData(error: "Error: ${response.statusCode}");
    }on DioException catch (e) {
      return UniversalData(error: "Dio Error: $e");
    } catch (e) {
      return UniversalData(error: e.toString());
    }
  }

  // ---------------CATEGORIES-------------------

  Future<UniversalData> getAllCategoryProducts() async {
    Response response;
    print("fs");
    try {
      response = await _dio.get("/products/categories");
      if (response.statusCode == 200) {
        print("Succees");
        return UniversalData(
          data: (response.data as List?)
              ?.map((e) => e as String)
              .toList() ??
              [],
        );
      }
      return UniversalData(error: "Error: ${response.statusCode}");
    }on DioException catch (e) {
      return UniversalData(error: "Dio Error: $e");
    } catch (e) {
      return UniversalData(error: e.toString());
    }
  }

}