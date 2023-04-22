import 'package:den_ecommerce/core/api_manager.dart';
import 'package:den_ecommerce/provider/app_provider.dart';
import 'package:get_it/get_it.dart';

import '../provider/order_provider.dart';
import '../provider/product_provider.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // Api Manager
  locator.registerLazySingleton<ApiManager>(
    () => ApiManager(),
  );

  locator.registerLazySingleton<ProductProvider>(
    () => ProductProvider(),
  );

  locator.registerLazySingleton<OrderProvider>(
    () => OrderProvider(),
  );

    locator.registerLazySingleton<AppProvider>(
    () => AppProvider(),
  );
}
