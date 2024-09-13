class Product {
  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  final int? id;
  final String? title;
  final double? price;
  final String? description;
  final String? category;
  final String? image;
  final Rating? rating;


  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      title: json["title"],
      price: (json["price"] as num?)?.toDouble(),
      description: json["description"],
      category: json["category"],
      image: json["image"],
      rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
    );
  }
}

class Rating {
  Rating({
    required this.rate,
    required this.count,
  });

  final double? rate;
  final int? count;


  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: (json["rate"] as num?)?.toDouble(),
      count: json["count"],
    );
  }
}
