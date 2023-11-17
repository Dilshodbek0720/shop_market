import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:shop_market/data/models/orders/client_order_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static final LocalDatabase getInstance = LocalDatabase._init();

  LocalDatabase._init();

  factory LocalDatabase() {
    return getInstance;
  }

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("order.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const intType = "INTEGER";

    await db.execute('''
    CREATE TABLE ${ClientOrderModelFields.tableName} (
    ${ClientOrderModelFields.id} $idType,
    ${ClientOrderModelFields.title} $textType,
    ${ClientOrderModelFields.description} $textType,
    ${ClientOrderModelFields.count} $intType,
    ${ClientOrderModelFields.price} $textType,
    ${ClientOrderModelFields.image} $textType,
    ${ClientOrderModelFields.productId} $intType
    )
    ''');

    debugPrint("-------DB----------CREATED---------");
  }

  static Future<ClientOrderModel> insertOrders(
      ClientOrderModel clientOrderModel) async {
    final db = await getInstance.database;
    final int id = await db.insert(
        ClientOrderModelFields.tableName, clientOrderModel.toJson());
    return clientOrderModel.copyWith(id: id);
  }

  static Future<List<ClientOrderModel>> getAllOrders() async {
    List<ClientOrderModel> allNews = [];
    final db = await getInstance.database;
    allNews = (await db.query(ClientOrderModelFields.tableName))
        .map((e) => ClientOrderModel.fromJson(e))
        .toList();

    return allNews;
  }

  static updateOrder({required ClientOrderModel clientOrderModel}) async {
    final db = await getInstance.database;
    db.update(
      ClientOrderModelFields.tableName,
      clientOrderModel.toJson(),
      where: "${ClientOrderModelFields.id} = ?",
      whereArgs: [clientOrderModel.id],
    );
  }

  static Future<int> deleteOrder(int id) async {
    final db = await getInstance.database;
    int count = await db.delete(
      ClientOrderModelFields.tableName,
      where: "${ClientOrderModelFields.id} = ?",
      whereArgs: [id],
    );
    return count;
  }

  static Future<List<ClientOrderModel>> getOrdersByLimit(int limit) async {
    List<ClientOrderModel> allOrders = [];
    final db = await getInstance.database;
    allOrders = (await db.query(ClientOrderModelFields.tableName,
        limit: limit, orderBy: "${ClientOrderModelFields.title} ASC"))
        .map((e) => ClientOrderModel.fromJson(e))
        .toList();

    return allOrders;
  }

  static Future<ClientOrderModel?> getSingleOrder(int id) async {
    List<ClientOrderModel> orders = [];
    final db = await getInstance.database;
    orders = (await db.query(
      ClientOrderModelFields.tableName,
      where: "${ClientOrderModelFields.id} = ?",
      whereArgs: [id],
    ))
        .map((e) => ClientOrderModel.fromJson(e))
        .toList();

    if (orders.isNotEmpty) {
      return orders.first;
    }
  }

  static Future<List<ClientOrderModel>> getOrdersByAlphabet(
      String order) async {
    List<ClientOrderModel> allOrders = [];
    final db = await getInstance.database;
    allOrders = (await db.query(ClientOrderModelFields.tableName,
        orderBy: "${ClientOrderModelFields.title} $order"))
        .map((e) => ClientOrderModel.fromJson(e))
        .toList();
    return allOrders;
  }
}