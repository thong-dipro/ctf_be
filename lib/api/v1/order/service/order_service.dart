import 'package:backend/api/v1/order/repository/order_repository.dart';
import 'package:backend/core/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:models/models.dart';

class OrderService {
  const OrderService({
    required OrderRepository repository,
  }) : _orderRepository = repository;
  final OrderRepository _orderRepository;

  Future<Either<FailureModel, List<OrderModel>>> getAllOrders() async {
    try {
      final result = await _orderRepository.getOrders();
      return right(result);
    } on NoOrderFoundException catch (e) {
      return left(FailureModel(message: e.message));
    } on DatabaseConnectionException catch (e) {
      return left(FailureModel(message: e.message));
    } catch (_) {
      return left(const FailureModel(message: UnknownException.message));
    }
  }

// create order
  Future<Either<FailureModel, void>> createOrder(OrderModel order) async {
    try {
      final result = await _orderRepository.saveOrder(order);
      return right(result);
    } on OrderAlreadyExistsException catch (e) {
      return left(FailureModel(message: e.message));
    } on DatabaseConnectionException catch (e) {
      return left(FailureModel(message: e.message));
    } catch (_) {
      return left(const FailureModel(message: UnknownException.message));
    }
  }
}
