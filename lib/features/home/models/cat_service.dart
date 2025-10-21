import 'package:cloud_firestore/cloud_firestore.dart';

class CatService {
  final String id;
  final String name;
  final String nameAr;
  final String image;
  final String icon;

  const CatService({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.image,
    required this.icon,
  });

  CatService copyWith({
    String? id,
    String? name,
    String? nameAr,
    String? image,
    String? icon,
  }) {
    return CatService(
      id: id ?? this.id,
      name: name ?? this.name,
      nameAr: nameAr ?? this.nameAr,
      image: image ?? this.image,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'nameAr': nameAr,
      'image': image,
      'icon': icon,
    };
  }

  factory CatService.fromMap(Map<String, dynamic>? data, {required String id}) {
    final map = data ?? <String, dynamic>{};
    return CatService(
      id: map['id'] as String? ?? id,
      name: map['name'] as String? ?? '',
      nameAr: map['nameAr'] as String? ?? '',
      image: map['image'] as String? ?? '',
      icon: map['icon'] as String? ?? '',
    );
  }

  factory CatService.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    return CatService.fromMap(doc.data(), id: doc.id);
  }
}
