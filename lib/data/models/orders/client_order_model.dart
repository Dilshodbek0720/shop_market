import 'package:equatable/equatable.dart';

class ClientOrderModelFields {
  static const String id = "_id";
  static const String tableName = "table_name";
  static const String title = "title";
  static const String description = "description";
  static const String price = "price";
  static const String image = "image";
  static const String count = "count";
  static const String productId = "productId";
}

class ClientOrderModel extends Equatable {
  int? id;
  final String title;
  final String description;
  final String price;
  final String image;
  final int count;
  final int productId;

  ClientOrderModel(
      {this.id,
        required this.title,
        required this.description,
        required this.price,
        required this.image,
        required this.count,
        required this.productId,
      });

  ClientOrderModel.initial()
      : this(
    id: 0,
    title: '',
    description: '',
    price: '',
    image: '',
    count: 0,
    productId: 0,
  );

  ClientOrderModel copyWith({
    int? id,
    String? title,
    String? description,
    String? price,
    String? image,
    int? count,
    int? productId,
  }) =>
      ClientOrderModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        price: price ?? this.price,
        image: image ?? this.image,
        count: count ?? this.count,
        productId: productId ?? this.productId,
      );

  factory ClientOrderModel.fromJson(Map<String, dynamic> json) => ClientOrderModel(
    id: json[ClientOrderModelFields.id] ?? 0,
    title: json['title'] as String? ?? '',
    description: json['description'] as String? ?? '',
    price: json['price'] as String? ?? '',
    image: json['image'] as String? ?? '',
    count: json['count'] as int? ?? 0,
    productId: json['productId'] as int? ?? 0,
  );

  Map<String, dynamic> toJson() => {
    ClientOrderModelFields.id: id,
    ClientOrderModelFields.title: title,
    ClientOrderModelFields.description: description,
    ClientOrderModelFields.price: price,
    ClientOrderModelFields.image: image,
    ClientOrderModelFields.count: count,
    ClientOrderModelFields.productId: productId,
  };

  @override
  String toString() {
    return '''
    id: $id
    title: $title
    description: $description
    price: $price
    image: $image
    productId: $productId
        ''';
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    price,
    image,
    count,
    productId,
  ];
}