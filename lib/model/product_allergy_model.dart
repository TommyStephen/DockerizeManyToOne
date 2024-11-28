class ProductAllergyModel {
  int? id;
  String allergyName;
  String allergyDescription;
  String allergyLink;

  ProductAllergyModel({
    this.id,
    required this.allergyName,
    required this.allergyDescription,
    required this.allergyLink,
  });

  factory ProductAllergyModel.fromJson(Map<String, dynamic> json) {
    return ProductAllergyModel(
      id: json['id'],
      allergyName: json['allergyName'],
      allergyDescription: json['allergyDescription'],
      allergyLink: json['allergyLink'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'allergyName': allergyName,
      'allergyDescription': allergyDescription,
      'allergyLink': allergyLink,
    };
  }
}
