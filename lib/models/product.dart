class Product {
  String name;
  String price;
  String imagePath;
  String rating;
  String brand;

  Product({
    required this.name,
    required this.price,
    required this.imagePath,
    required this.rating,
    required this.brand,
  });

  String get _name => name;
  String get _price => price;
  String get _imagePath => imagePath;
  String get _rating => rating;
  String get _brand => brand;
}
