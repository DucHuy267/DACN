class Category {
  final String categoryId;
  final String categoryName;
  final String image;


  Category({
    required this.categoryId,
    required this.categoryName,
    required this.image,

  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'image': image,

    };
  }


}
