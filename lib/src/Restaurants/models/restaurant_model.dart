class Restaurant {
  final String name;
  final String? description;
  final String? imageUrl;
  final double? rating;

  Restaurant({
    required this.name,
    this.description,
    this.imageUrl,
    this.rating,
  });

  Restaurant.fromJson(Map<String, dynamic> json)
      : name = json['poi']["name"],
        description = json['poi']["phone"],
        imageUrl = null,
        rating = 4.3;
}
