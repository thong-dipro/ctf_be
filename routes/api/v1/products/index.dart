import 'dart:io';

import 'package:backend/api/v1/product/product_mock.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method == HttpMethod.get) {
    return _getAllProducts(context);
  }
  return Response(statusCode: HttpStatus.methodNotAllowed);
}

Future<Response> _getAllProducts(RequestContext context) async {
  final response = ProductMock().getAllProduct;

  return Response.json(
    body: response,
  );
}
