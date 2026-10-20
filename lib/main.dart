import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/order_controller.dart';
import 'views/screens/menu_view.dart';

void main() {
  runApp(const RestaurantOrderApp());
}

class RestaurantOrderApp extends StatelessWidget {
  const RestaurantOrderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrderController(),
      child: MaterialApp(
        title: 'Restaurant Order App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          useMaterial3: true,
        ),
        home: const MenuView(),
      ),
    );
  }
}
