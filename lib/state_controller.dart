import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:shopping_cart/hive/hive_product_model.dart';

class StateController extends ChangeNotifier {
  final shoppingCartBox = Hive.box<ProductModel>('shoppingCart');

  late List<ProductModel> allProducts;

  double totalCartValue = 0;

  addToCart(
      {required int id,
      required String title,
      required double price,
      required int qty,
      required String imgUrl}) {
    ProductModel product = ProductModel(
      id: id,
      title: title,
      price: price,
      qty: qty,
      imgUrl: imgUrl,
    );
    shoppingCartBox.add(product);
    notifyListeners();
  }

  Future<void> deleteCart({required int index}) async {
    shoppingCartBox.deleteAt(index);
    getAllCart();
    notifyListeners();
  }

  getAllCart() {
    allProducts = shoppingCartBox.values.toList();
    totalProductPrice();
    notifyListeners();
  }

  addProductQty({
    required int index,
    required int quantity,
  }) {
    final existingProduct = shoppingCartBox.getAt(index);
    if (existingProduct != null) {
      existingProduct.qty = quantity;
      shoppingCartBox.putAt(index, existingProduct);
      getAllCart();
      notifyListeners();
      print('Quantity updated for product at index $index.');
    } else {
      print('No product found at index $index.');
    }
  }

  removeProductQty({
    required int index,
    required int quantity,
  }) {
    final existingProduct = shoppingCartBox.getAt(index);
    if (existingProduct != null) {
      if (quantity > 1) {
        shoppingCartBox.putAt(index, quantity as ProductModel);
        getAllCart();
        notifyListeners();
        print('Quantity updated for product at index $index.');
      } else {
        print('Quantity for product at index $index is already 1 or less.');
      }
    } else {
      print('No product found at index $index.');
    }
  }

  totalProductPrice() {
    totalCartValue = 0;
    for (var f in allProducts) {
      totalCartValue += f.price * f.qty;
    }
  }
}
