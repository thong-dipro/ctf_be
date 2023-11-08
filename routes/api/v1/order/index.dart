import 'dart:io';

import 'package:backend/api/v1/order/service/order_service.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:models/models.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method == HttpMethod.post) {
    return _createOrder(context);
  }
  if (context.request.method == HttpMethod.get) {
    return _getUserProfile(context);
  }
  return Response(statusCode: HttpStatus.methodNotAllowed);
}

Future<Response> _getUserProfile(RequestContext context) async {
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
  final orderModel = OrderModel.fromJson({
    ...await context.request.json() as Map<String, dynamic>,
    'createdAt': DateTime.now().toUtc().toString(),
  });
  await orderService.createOrder(
    orderModel,
  );
  return Response.json(
    statusCode: HttpStatus.created,
    body: 'Ok',
  );
}
