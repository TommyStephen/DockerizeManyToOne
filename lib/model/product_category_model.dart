class ProductCategoryModel {
  int? id;
  String categoryName;

  ProductCategoryModel({
    this.id,
    required this.categoryName,
  });

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductCategoryModel(
      id: json['id'],
      categoryName: json['categoryName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'categoryName': categoryName};
  }
}
