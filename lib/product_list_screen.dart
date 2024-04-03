import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/cart_screen.dart';
import 'package:shopping_cart/product_controller.dart';
import 'package:shopping_cart/state_controller.dart';
import 'hive/hive_product_model.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
        actions: <Widget>[
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
              ),
              Consumer<StateController>(
                builder: (context, stateControllerData, child) {
                  if (stateControllerData.shoppingCartBox.isNotEmpty) {
                    return stateControllerData.shoppingCartBox.length == 0
                        ? const SizedBox.shrink()
                        : Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                                height: 18,
                                width: 18,
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                    child: Text(
                                  stateControllerData.shoppingCartBox.length
                                      .toString(),
                                  style: const TextStyle(color: Colors.white),
                                ))),
                          );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )
            ],
          )
        ],
      ),
      body: Consumer<ProductController>(
        builder: (context, productControllerData, child) {
          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: productControllerData.productList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.8),
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  children: [
                    Image.network(
                      productControllerData.productList[index].imgUrl,
                      height: 120,
                      width: 120,
                    ),
                    Text(
                      productControllerData.productList[index].title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("\$${productControllerData.productList[index].price}"),
                    Consumer<StateController>(
                      builder: (context, stateControllerData, child) {
                        return ElevatedButton(
                            onPressed: () async {
                              ProductModel product = ProductModel(
                                id: productControllerData.productList[index].id,
                                title: productControllerData
                                    .productList[index].title,
                                price: productControllerData
                                    .productList[index].price,
                                qty: productControllerData
                                    .productList[index].qty,
                                imgUrl: productControllerData
                                    .productList[index].imgUrl,
                              );
                              await stateControllerData.addToCart(
                                  product: product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Item Successfully added to cart!'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            },
                            child: const Text("Add"));
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
