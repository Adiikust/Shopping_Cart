import 'package:hive/hive.dart';
part 'hive_product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String imgUrl;

  @HiveField(3)
  double price;

  @HiveField(4)
  int qty;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.qty,
    required this.imgUrl,
  });
}
