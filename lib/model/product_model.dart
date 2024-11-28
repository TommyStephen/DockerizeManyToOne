import 'package:product_demo/model/product_allergy_model.dart';
import 'package:product_demo/model/product_social_media_model.dart';

class ProductModel {
  int? id;
  String? productName;
  String? productLocalName;
  String? productDescription;
  double? price;
  String? uom;
  String? productImagePath;
  String? image;
  int? categoryId;
  ProductSocialMediaModel? productSocialMedia;
  ProductAllergyModel? productAllergy;

  ProductModel({
    this.id,
    this.productName,
    this.productLocalName,
    this.productDescription,
    this.price,
    this.uom,
    this.productImagePath,
    this.image,
    this.categoryId,
    this.productSocialMedia,
    this.productAllergy,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      productName: json['productName'],
      productLocalName: json['productLocalName'],
      productDescription: json['productDescription'],
      price: json['price'],
      uom: json['uom'],
      productImagePath: json['productImagePath'],
      image: json['image'],
      categoryId: json['categoryId'],
      productSocialMedia:
          ProductSocialMediaModel.fromJson(json['productSocialMedia']),
      productAllergy: ProductAllergyModel.fromJson(json['productAllergy']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'productLocalName': productLocalName,
      'productDescription': productDescription,
      'price': price,
      'uom': uom,
      'categoryId': categoryId,
      'productSocialMedia': productSocialMedia?.toJson(),
      'productAllergy': productAllergy?.toJson(),
    };
  }
}

class ProductAllergy {
  String allergyName;
  String allergyDescription;
  String allergyLink;

  ProductAllergy({
    required this.allergyName,
    required this.allergyDescription,
    required this.allergyLink,
  });

  factory ProductAllergy.fromJson(Map<String, dynamic> json) {
    return ProductAllergy(
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
