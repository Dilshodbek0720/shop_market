import 'package:equatable/equatable.dart';

class ClientOrderModelFields {
  static const String id = "_id";
  static const String name = "name";
  static const String description = "description";
  static const String price = "price";
  static const String image = "image";
  static const String count = "count";
  static const String productId = "productId";
}

class ClientOrderModel extends Equatable {
  int? id;
  final String name;
  final String description;
  final int price;
  final String image;
  final int count;

  ClientOrderModel(
      {this.id,
        required this.name,
        required this.description,
        required this.price,
        required this.image,
        required this.count,
      });

  ClientOrderModel.initial()
      : this(
    id: 0,
    name: '',
    description: '',
    price: 0,
    image: '',
    count: 0,
  );

  ClientOrderModel copyWith({
    int? id,
    String? name,
    String? description,
    int? price,
    String? image,
    int? count,
  }) =>
      ClientOrderModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        image: image ?? this.image,
        count: count ?? this.count,
      );

  factory ClientOrderModel.fromJson(Map<String, dynamic> json) => ClientOrderModel(
    id: json[ClientOrderModelFields.id] ?? 0,
    name: json['name'] as String? ?? '',
    description: json['description'] as String? ?? '',
    price: json['price'] as int? ?? 0,
    image: json['image'] as String? ?? '',
    count: json['count'] as int? ?? 0,
  );

  Map<String, dynamic> toJson() => {
    ClientOrderModelFields.id: id,
    'name': name,
    'description': description,
    'price': price,
    'image': image,
    'count': count
  };

  @override
  String toString() {
    return '''
    id: $id
    name: $name
    description: $description
    price: $price
    image: $image
        ''';
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    image,
    count,
  ];
}