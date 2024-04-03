class ProductModel {
  int id;
  String title;
  String imgUrl;
  double price;
  int qty;

  ProductModel(
      {required this.id,
      required this.title,
      required this.price,
      required this.qty,
      required this.imgUrl});
}
