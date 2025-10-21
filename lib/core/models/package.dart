import 'package:cloud_firestore/cloud_firestore.dart';


class Package {
  final String id;
  final String name;
  final String nameEn;
  final String description;
  final String descriptionEn;
  final int minDays;
  final double price;
  final double discountPrice; // Original price before discount
  final String category;
  final String categoryEn;
  final String brandName;
  final String brandEmail;
  final String brandImage;
  final String image;
  final List<String> includedServices; // List of service IDs included in package
  final bool isPopular; // To mark popular packages
  final int validityDays; // How long the package is valid for

  const Package({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.description,
    required this.descriptionEn,
    required this.minDays,
    required this.price,
    required this.discountPrice,
    required this.category,
    required this.categoryEn,
    required this.brandName,
    required this.brandEmail,
    required this.brandImage,
    required this.image,
    required this.includedServices,
    required this.isPopular,
    required this.validityDays,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'nameEn': nameEn,
      'des': description,
      'desEn': descriptionEn,
      'minDays': minDays,
      'price': price,
      'discountPrice': discountPrice,
      'cat': category,
      'catEn': categoryEn,
      'brandName': brandName,
      'brandEmail': brandEmail,
      'brandImage': brandImage,
      'image': image,
      'includedServices': includedServices,
      'isPopular': isPopular,
      'validityDays': validityDays,
    };
  }

  factory Package.fromMap(Map<String, dynamic>? data, {required String id}) {
    final map = data ?? <String, dynamic>{};
    return Package(
      id: map['id'] as String? ?? id,
      name: map['name'] as String? ?? '',
      nameEn: map['nameEn'] as String? ?? '',
      description: map['des'] as String? ?? '',
      descriptionEn: map['desEn'] as String? ?? '',
      minDays: (map['minDays'] as num?)?.toInt() ?? 0,
      price: (map['price'] as num?)?.toDouble() ?? 0,
      discountPrice: (map['discountPrice'] as num?)?.toDouble() ?? 0,
      category: map['cat'] as String? ?? '',
      categoryEn: map['catEn'] as String? ?? '',
      brandName: map['brandName'] as String? ?? '',
      brandEmail: map['brandEmail'] as String? ?? '',
      brandImage: map['brandImage'] as String? ?? '',
      image: map['image'] as String? ?? '',
      includedServices: List<String>.from(map['includedServices'] ?? []),
      isPopular: map['isPopular'] as bool? ?? false,
      validityDays: (map['validityDays'] as num?)?.toInt() ?? 30,
    );
  }

  factory Package.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    return Package.fromMap(doc.data(), id: doc.id);
  }

  // Helper methods
  double get discountPercentage {
    if (discountPrice <= 0 || price <= 0) return 0;
    return ((discountPrice - price) / discountPrice * 100);
  }

  bool get hasDiscount => discountPrice > price && discountPrice > 0;
}