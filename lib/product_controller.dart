import 'package:flutter/material.dart';
import 'package:shopping_cart/product_model.dart';

class ProductController extends ChangeNotifier {
  List<ProductModel> productList = [
    ProductModel(
        id: 1,
        title: "Apple",
        price: 20.0,
        imgUrl: "https://img.icons8.com/plasticine/2x/apple.png",
        qty: 1),
    ProductModel(
        id: 2,
        title: "Banana",
        price: 40.0,
        imgUrl: "https://img.icons8.com/cotton/2x/banana.png",
        qty: 1),
    ProductModel(
        id: 3,
        title: "Orange",
        price: 20.0,
        imgUrl: "https://img.icons8.com/cotton/2x/orange.png",
        qty: 1),
    ProductModel(
        id: 4,
        title: "Melon",
        price: 40.0,
        imgUrl: "https://img.icons8.com/cotton/2x/watermelon.png",
        qty: 1),
    ProductModel(
        id: 5,
        title: "Avocado",
        price: 25.0,
        imgUrl: "https://img.icons8.com/cotton/2x/avocado.png",
        qty: 1),
  ];
}
