import 'package:dart_frog/dart_frog.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart' as shelf;

Handler middleware(Handler handler) {
  return handler.use(
    fromShelfMiddleware(
      shelf.corsHeaders(
        headers: {
          shelf.ACCESS_CONTROL_ALLOW_ORIGIN:
              '*', // Required for CORS support to work
          shelf.ACCESS_CONTROL_ALLOW_METHODS:
              'GET, POST, OPTIONS, PUT, DELETE, HEAD',
          shelf.ACCESS_CONTROL_ALLOW_HEADERS:
              'Origin, Content-Type, X-Auth-Token',
        },
      ),
    ),
  );
}
