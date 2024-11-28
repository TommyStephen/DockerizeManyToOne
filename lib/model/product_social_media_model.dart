class ProductSocialMediaModel {
  int? id;
  String socialMediaLink;

  ProductSocialMediaModel({this.id, required this.socialMediaLink});

  factory ProductSocialMediaModel.fromJson(Map<String, dynamic> json) {
    return ProductSocialMediaModel(
      id: json['id'],
      socialMediaLink: json['socialMediaLink'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'socialMediaLink': socialMediaLink};
  }
}
