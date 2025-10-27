import 'package:cloud_firestore/cloud_firestore.dart';

class Brand {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String nameAr;
  final String image;
  final String description;
  final String descriptionEn;
  final String category;
  final String categoryEn;
  final double rating;
  final int reviewCount;
  final int deliveryTime;

  const Brand({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.image,
    required this.email,
    required this.phone,
    required this.description,
    required this.descriptionEn,
    required this.category,
    required this.categoryEn,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.deliveryTime = 2,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'nameAr': nameAr,
      'image': image,
      'email': email,
      'phone': phone,
      'des': description,
      'desEn': descriptionEn,
      'cat': category,
      'catEn': categoryEn,
      'rating': rating,
      'reviewCount': reviewCount,
      'deliveryTime': deliveryTime,
    };
  }

  factory Brand.fromMap(Map<String, dynamic>? data, {required String id}) {
    final map = data ?? <String, dynamic>{};
    return Brand(
      id: map['id'] as String? ?? id,
      email: map['email'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      name: map['name'] as String? ?? '',
      nameAr: map['nameAr'] as String? ?? '',
      image: map['image'] as String? ?? '',
      description: map['des'] as String? ?? '',
      descriptionEn: map['desEn'] as String? ?? '',
      category: map['cat'] as String? ?? '',
      categoryEn: map['catEn'] as String? ?? '',
      rating: (map['rating'] ?? 0.0).toDouble(),
      reviewCount: (map['reviewCount'] ?? 0).toInt(),
      deliveryTime: (map['deliveryTime'] ?? 2).toInt(),
    );
  }

  factory Brand.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    return Brand.fromMap(doc.data(), id: doc.id);
  }
}
