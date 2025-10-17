import 'package:cloud_firestore/cloud_firestore.dart';

class Service {
  final String id;
  final String name;
  final String nameEn;
  final String description;
  final String descriptionEn;
  final int minDays;
  final double price;
  final String category;
  final String categoryEn;
  final String brandName;
  final String brandEmail;
  final String brandImage;

  const Service({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.description,
    required this.descriptionEn,
    required this.minDays,
    required this.price,
    required this.category,
    required this.categoryEn,
    required this.brandName,
    required this.brandEmail,
    required this.brandImage,
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
      'cat': category,
      'catEn': categoryEn,
      'brandName': brandName,
      'brandEmail': brandEmail,
      'brandImage': brandImage,
    };
  }

  factory Service.fromMap(Map<String, dynamic>? data, {required String id}) {
    final map = data ?? <String, dynamic>{};
    return Service(
      id: map['id'] as String? ?? id,
      name: map['name'] as String? ?? '',
      nameEn: map['nameEn'] as String? ?? '',
      description: map['des'] as String? ?? '',
      descriptionEn: map['desEn'] as String? ?? '',
      minDays: (map['minDays'] as num?)?.toInt() ?? 0,
      price: (map['price'] as num?)?.toDouble() ?? 0,
      category: map['cat'] as String? ?? '',
      categoryEn: map['catEn'] as String? ?? '',
      brandName: map['brandName'] as String? ?? '',
      brandEmail: map['brandEmail'] as String? ?? '',
      brandImage: map['brandImage'] as String? ?? '',
    );
  }

  factory Service.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    return Service.fromMap(doc.data(), id: doc.id);
  }
}
