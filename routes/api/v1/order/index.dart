import 'dart:io';

import 'package:backend/api/v1/order/service/order_service.dart';
import 'package:backend/api/v1/product/product_mock.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:models/models.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method == HttpMethod.post) {
    return _createOrder(context);
  }
  if (context.request.method == HttpMethod.get) {
    return _getAllOrders(context);
  }
  return Response(statusCode: HttpStatus.methodNotAllowed);
}

Future<Response> _getAllOrders(RequestContext context) async {
  final orderService = context.read<OrderService>();
  final response = await orderService.getAllOrders();

  return response.fold(
    (error) => Response.json(
      statusCode: HttpStatus.internalServerError,
      body: error.toJson(),
    ),
    // Return code 200, user information if everthing is fine.
    (success) => Response.json(
      body: success,
    ),
  );
}

Future<Response> _createOrder(RequestContext context) async {
  final orderService = context.read<OrderService>();
  final response = await context.request.json() as Map<String, dynamic>;
  final price = response['price'] as int;
  final productId = response['productId'] as int;
  final canBuy = ProductMock().getAllProduct.any(
        (element) => element.id == productId && element.price <= price,
      );
  print(price);
  print(productId);
  if (!canBuy) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: 'Your balance is not enough to buy this product',
    );
  }
  final orderModel = OrderModel.fromJson({
    ...response,
    'createdAt': DateTime.now().toUtc().toString(),
  });
  if (productId == 1004) {
    await orderService.createOrder(
      orderModel,
    );
  }
  return Response.json(
    statusCode: HttpStatus.created,
    body: 'Ok',
  );
}
