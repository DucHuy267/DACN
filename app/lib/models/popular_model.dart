class Popular {
  final int id;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String categoryId;
  final String imageUrl;

  Popular({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.categoryId,
    required this.imageUrl,
  });

  factory Popular.fromJson(Map<String, dynamic> json) {
    return Popular(
      id: int.tryParse(json['_id'].toString()) ?? 0, // Ensures `_id` is an integer
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      categoryId: json['categoryId'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'categoryId': categoryId,
      'imageUrl': imageUrl,
    };
  }
}
