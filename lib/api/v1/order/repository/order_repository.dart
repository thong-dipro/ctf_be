import 'package:backend/core/constants/db_constants.dart';
import 'package:backend/core/database/database.dart';
import 'package:models/models.dart';

class OrderRepository {
  const OrderRepository({
    required DatabaseClient client,
  }) : _databaseClient = client;

  final DatabaseClient _databaseClient;

  Future<void> saveOrder(OrderModel order) async {
    final orderCollection = _databaseClient.db!.collection(
      DBConstants.ordersCollection,
    );
    await orderCollection.insert(order.toJson());
  }

  Future<List<OrderModel>> getOrders() async {
    final orderCollection = _databaseClient.db!.collection(
      DBConstants.ordersCollection,
    );
    final orders = await orderCollection.find().toList();
    return orders.map(OrderModel.fromJson).toList();
  }
}
