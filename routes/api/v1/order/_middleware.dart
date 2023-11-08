import 'package:backend/api/v1/order/repository/order_repository.dart';
import 'package:backend/api/v1/order/service/order_service.dart';
import 'package:backend/api/v1/profile/repository/profile_repository.dart';
import 'package:backend/api/v1/profile/service/profile_service.dart';
import 'package:backend/core/database/database.dart';
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return handler
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
