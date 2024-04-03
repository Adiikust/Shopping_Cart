import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/state_controller.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<StateController>(context, listen: false).getAllCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Cart"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Consumer<StateController>(
          builder: (context, stateControllerData, child) {
            return stateControllerData.allProducts.isNotEmpty
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: stateControllerData.allProducts.length,
                          itemBuilder: (context, index) {
                            final data = stateControllerData.allProducts[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Container(
                                height: 80,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(data.imgUrl),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          data.title,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          "\$${data.price}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            stateControllerData
                                                .deleteCart(index: index)
                                                .then((value) {
                                              const snackBar = SnackBar(
                                                  content: Text(
                                                      'Delete Shopping Item'));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            });
                                          },
                                          child: const Icon(
                                            Icons.cancel,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                stateControllerData
                                                    .addProductQty(
                                                        index: index,
                                                        quantity: data.qty - 1);
                                              },
                                              child: const Icon(
                                                CupertinoIcons
                                                    .minus_circle_fill,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              data.qty.toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            ),
                                            const SizedBox(width: 10),
                                            GestureDetector(
                                              onTap: () {
                                                stateControllerData
                                                    .addProductQty(
                                                        index: index,
                                                        quantity: data.qty + 1);
                                              },
                                              child: const Icon(
                                                CupertinoIcons
                                                    .add_circled_solid,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox.shrink()
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total Items",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                            Text(
                              stateControllerData.allProducts.length.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14),
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Price",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                            Text(
                              "\$20",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14),
                            ),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              "DONE",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: Colors.black),
                            ))
                      ],
                    ),
                  )
                : const Center(
                    child: Text(
                    "No Shopping cart add",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ));
          },
        ),
      ),
    );
  }
}
