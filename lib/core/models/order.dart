import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String id;
  final String userId;
  final String userEmail;
  final String userName;
  final String orderType; // 'service' or 'package'
  final DateTime orderDate;
  final double totalPrice;
  final String status; // 'pending', 'confirmed', 'completed', 'cancelled'
  final String? userCountry;
  final String? userCity;
  final double? userLatitude;
  final double? userLongitude;
  final String? userLocationName;
  final String? userFullAddress;
  
  // Brand information
  final String brandName;
  final String brandEmail;
  final String brandImage;
  
  // Order items (services or packages)
  final List<Map<String, dynamic>> items;
  
  // Additional notes
  final String? notes;

  const Order({
    required this.id,
    required this.userId,
    required this.userEmail,
    required this.userName,
    required this.orderType,
    required this.orderDate,
    required this.totalPrice,
    required this.status,
    this.userCountry,
    this.userCity,
    this.userLatitude,
    this.userLongitude,
    this.userLocationName,
    this.userFullAddress,
    required this.brandName,
    required this.brandEmail,
    required this.brandImage,
    required this.items,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'userEmail': userEmail,
      'userName': userName,
      'orderType': orderType,
      'orderDate': orderDate.toIso8601String(),
      'totalPrice': totalPrice,
      'status': status,
      'userCountry': userCountry,
      'userCity': userCity,
      'userLatitude': userLatitude,
      'userLongitude': userLongitude,
      'userLocationName': userLocationName,
      'userFullAddress': userFullAddress,
      'brandName': brandName,
      'brandEmail': brandEmail,
      'brandImage': brandImage,
      'items': items,
      'notes': notes,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map, String documentId) {
    return Order(
      id: documentId,
      userId: map['userId'] as String? ?? '',
      userEmail: map['userEmail'] as String? ?? '',
      userName: map['userName'] as String? ?? '',
      orderType: map['orderType'] as String? ?? '',
      orderDate: map['orderDate'] != null 
          ? DateTime.parse(map['orderDate'] as String)
          : DateTime.now(),
      totalPrice: (map['totalPrice'] as num?)?.toDouble() ?? 0.0,
      status: map['status'] as String? ?? 'pending',
      userCountry: map['userCountry'] as String?,
      userCity: map['userCity'] as String?,
      userLatitude: (map['userLatitude'] as num?)?.toDouble(),
      userLongitude: (map['userLongitude'] as num?)?.toDouble(),
      userLocationName: map['userLocationName'] as String?,
      userFullAddress: map['userFullAddress'] as String?,
      brandName: map['brandName'] as String? ?? '',
      brandEmail: map['brandEmail'] as String? ?? '',
      brandImage: map['brandImage'] as String? ?? '',
      items: (map['items'] as List<dynamic>?)
          ?.map((item) => item as Map<String, dynamic>)
          .toList() ?? [],
      notes: map['notes'] as String?,
    );
  }

  factory Order.fromDocument(DocumentSnapshot doc) {
    return Order.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }
}
