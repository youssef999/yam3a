import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String? id;
  final String userId;
  final String userEmail;
  final String userName;
  final String orderType;
  final String orderDate;
  final double totalPrice;
  final String status;
  final String paymentMethod;
  final String paymentStatus;
  final DeliveryLocation deliveryLocation;
  final String brandName;
  final String brandEmail;
  final String brandImage;
  final List<OrderItem> items;
  final int itemsCount;
  final Timestamp? createdAt;
  final Timestamp? updatedAt;

  OrderModel({
    this.id,
    required this.userId,
    required this.userEmail,
    required this.userName,
    required this.orderType,
    required this.orderDate,
    required this.totalPrice,
    required this.status,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.deliveryLocation,
    required this.brandName,
    required this.brandEmail,
    required this.brandImage,
    required this.items,
    required this.itemsCount,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    return OrderModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      userEmail: data['userEmail'] ?? '',
      userName: data['userName'] ?? '',
      orderType: data['orderType'] ?? '',
      orderDate: data['orderDate'] ?? '',
      totalPrice: (data['totalPrice'] ?? 0).toDouble(),
      status: data['status'] ?? 'pending',
      paymentMethod: data['paymentMethod'] ?? '',
      paymentStatus: data['paymentStatus'] ?? '',
      deliveryLocation: DeliveryLocation.fromMap(data['deliveryLocation'] ?? {}),
      brandName: data['brandName'] ?? '',
      brandEmail: data['brandEmail'] ?? '',
      brandImage: data['brandImage'] ?? '',
      items: (data['items'] as List<dynamic>?)
              ?.map((item) => OrderItem.fromMap(item as Map<String, dynamic>))
              .toList() ??
          [],
      itemsCount: data['itemsCount'] ?? 0,
      createdAt: data['createdAt'] as Timestamp?,
      updatedAt: data['updatedAt'] as Timestamp?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userEmail': userEmail,
      'userName': userName,
      'orderType': orderType,
      'orderDate': orderDate,
      'totalPrice': totalPrice,
      'status': status,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'deliveryLocation': deliveryLocation.toMap(),
      'brandName': brandName,
      'brandEmail': brandEmail,
      'brandImage': brandImage,
      'items': items.map((item) => item.toMap()).toList(),
      'itemsCount': itemsCount,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': updatedAt ?? FieldValue.serverTimestamp(),
    };
  }

  String getStatusText() {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'pending';
      case 'accepted':
        return 'accepted';
      case 'done':
        return 'completed';
      case 'canceled':
        return 'canceled';
      default:
        return status;
    }
  }

  String getFormattedDate() {
    try {
      final date = DateTime.parse(orderDate);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return orderDate;
    }
  }

  String getFormattedTime() {
    try {
      final date = DateTime.parse(orderDate);
      final hour = date.hour > 12 ? date.hour - 12 : date.hour;
      final period = date.hour >= 12 ? 'PM' : 'AM';
      return '${hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} $period';
    } catch (e) {
      return '';
    }
  }
}

class DeliveryLocation {
  final String country;
  final String city;
  final String area;
  final String floor;
  final String apartment;
  final String phone;
  final String fullAddress;
  final double latitude;
  final double longitude;

  DeliveryLocation({
    required this.country,
    required this.city,
    required this.area,
    required this.floor,
    required this.apartment,
    required this.phone,
    required this.fullAddress,
    required this.latitude,
    required this.longitude,
  });

  factory DeliveryLocation.fromMap(Map<String, dynamic> map) {
    return DeliveryLocation(
      country: map['country'] ?? '',
      city: map['city'] ?? '',
      area: map['area'] ?? '',
      floor: map['floor'] ?? '',
      apartment: map['apartment'] ?? '',
      phone: map['phone'] ?? '',
      fullAddress: map['fullAddress'] ?? '',
      latitude: (map['latitude'] ?? 0.0).toDouble(),
      longitude: (map['longitude'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'country': country,
      'city': city,
      'area': area,
      'floor': floor,
      'apartment': apartment,
      'phone': phone,
      'fullAddress': fullAddress,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  String getShortAddress() {
    final parts = <String>[];
    if (area.isNotEmpty) parts.add(area);
    if (city.isNotEmpty) parts.add(city);
    return parts.join(', ');
  }
}

class OrderItem {
  final String name;
  final String nameEn;
  final String des;
  final String desEn;
  final double price;
  final double? discountPrice;
  final String image;
  final String brandName;
  final String brandEmail;
  final String brandImage;
  final String cat;
  final String catEn;
  final String id;
  final bool? isPopular;
  final int? minDays;
  final int? validityDays;
  final List<String>? includedServices;

  OrderItem({
    required this.name,
    required this.nameEn,
    required this.des,
    required this.desEn,
    required this.price,
    this.discountPrice,
    required this.image,
    required this.brandName,
    required this.brandEmail,
    required this.brandImage,
    required this.cat,
    required this.catEn,
    required this.id,
    this.isPopular,
    this.minDays,
    this.validityDays,
    this.includedServices,
  });

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      name: map['name'] ?? '',
      nameEn: map['nameEn'] ?? '',
      des: map['des'] ?? '',
      desEn: map['desEn'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      discountPrice: map['discountPrice'] != null ? (map['discountPrice'] as num).toDouble() : null,
      image: map['image'] ?? '',
      brandName: map['brandName'] ?? '',
      brandEmail: map['brandEmail'] ?? '',
      brandImage: map['brandImage'] ?? '',
      cat: map['cat'] ?? '',
      catEn: map['catEn'] ?? '',
      id: map['id'] ?? '',
      isPopular: map['isPopular'] as bool?,
      minDays: map['minDays'] as int?,
      validityDays: map['validityDays'] as int?,
      includedServices: (map['includedServices'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {
      'name': name,
      'nameEn': nameEn,
      'des': des,
      'desEn': desEn,
      'price': price,
      'image': image,
      'brandName': brandName,
      'brandEmail': brandEmail,
      'brandImage': brandImage,
      'cat': cat,
      'catEn': catEn,
      'id': id,
    };

    if (discountPrice != null) data['discountPrice'] = discountPrice!;
    if (isPopular != null) data['isPopular'] = isPopular!;
    if (minDays != null) data['minDays'] = minDays!;
    if (validityDays != null) data['validityDays'] = validityDays!;
    if (includedServices != null) data['includedServices'] = includedServices!;

    return data;
  }

  double get finalPrice => discountPrice ?? price;
}
