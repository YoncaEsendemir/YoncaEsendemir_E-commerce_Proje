// 1. ANA KAPSAYICI MODEL (Tüm veri bunun içindeki 'data' listesinde olacak)
class ProductsModel {
  List<Product>? data; // Tüm liste bunun içinde saklanacak

  ProductsModel({this.data});

  // API'den gelen direkt listeyi alır ve içindeki 'data' değişkenine aktarır
  ProductsModel.fromJson(List<dynamic> jsonList) {
    data = jsonList.map((e) => Product.fromJson(e)).toList();
  }
}

// 2. TEK BİR ÜRÜNÜN MODELİ
class Product {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  Product({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price']?.toDouble(); // int/double hatasını önlemek için güvenli dönüşüm
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
  }
}

// 3. RATING MODELİ (Aynen kalabilir)
class Rating {
  double? rate;
  int? count;

  Rating({this.rate, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    rate = json['rate']?.toDouble();
    count = json['count'];
  }
}