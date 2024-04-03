import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:shopping_cart/hive/hive_product_model.dart';

class StateController extends ChangeNotifier {
  final shoppingCartBox = Hive.box<ProductModel>('shoppingCart');

  late List<ProductModel> allProducts;

  addToCart({required ProductModel product}) {
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
      existingProduct.qty = quantity;
      shoppingCartBox.putAt(index, existingProduct);
      getAllCart();
      notifyListeners();
      print('Quantity updated for product at index $index.');
    } else {
      print('No product found at index $index.');
    }
  }
}
