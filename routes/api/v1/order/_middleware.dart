import 'package:backend/api/v1/order/repository/order_repository.dart';
import 'package:backend/api/v1/order/service/order_service.dart';
import 'package:backend/api/v1/profile/repository/profile_repository.dart';
import 'package:backend/api/v1/profile/service/profile_service.dart';
import 'package:backend/core/database/database.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart' as shelf;

Handler middleware(Handler handler) {
  return handler
      .use(
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
      )
      .use(
        profileServiceProvider(),
      )
      .use(
        profileRepositoryProvider(),
      )
      .use(
        orderServiceProvider(),
      )
      .use(
        orderRepositoryProvider(),
      );
}

Middleware profileRepositoryProvider() {
  return provider<ProfileRepository>(
    (context) => ProfileRepository(
      databaseClient: context.read<DatabaseClient>(),
    ),
  );
}

Middleware profileServiceProvider() {
  return provider<ProfileService>(
    (context) => ProfileService(
      profileRepository: context.read<ProfileRepository>(),
    ),
  );
}

Middleware orderRepositoryProvider() {
  return provider<OrderRepository>(
    (context) => OrderRepository(
      client: context.read<DatabaseClient>(),
    ),
  );
}

Middleware orderServiceProvider() {
  return provider<OrderService>(
    (context) => OrderService(
      repository: context.read<OrderRepository>(),
    ),
  );
}
