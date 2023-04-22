import 'package:den_ecommerce/core/constant/den_theme.dart';
import 'package:den_ecommerce/provider/app_provider.dart';
import 'package:den_ecommerce/provider/order_provider.dart';
import 'package:den_ecommerce/screens/home_screen.dart';
import 'package:den_ecommerce/screens/login_screen.dart';
import 'package:den_ecommerce/screens/registration_screen.dart';
import 'package:den_ecommerce/screens/set_password.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/service_locator.dart';
import 'provider/product_provider.dart';

void main() async {
  await setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: locator<ProductProvider>(),
        ),
        ChangeNotifierProvider.value(
          value: locator<OrderProvider>(),
        ),
        ChangeNotifierProvider.value(
          value: locator<AppProvider>(),
        ),
      ],
      child: MaterialApp(
        title: 'Ecommerce App',
        debugShowCheckedModeBanner: false,
        home:
            //HomeScreen()
            LoginScreen(),
      ),
    );
  }
}
