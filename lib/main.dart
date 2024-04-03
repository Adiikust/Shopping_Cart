import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shopping_cart/product_controller.dart';
import 'package:shopping_cart/product_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:shopping_cart/state_controller.dart';
import 'hive/hive_product_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(ProductModelAdapter());
  await Hive.openBox<ProductModel>('shoppingCart');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductController()),
        ChangeNotifierProvider(create: (context) => StateController()),
      ],
      child: MaterialApp(
        title: 'Shopping Cart',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ProductListScreen(),
      ),
    );
  }
}
