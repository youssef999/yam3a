import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String id;
  final String orderId;
  final String userId;
  final String userEmail;
  final String userName;
  final String brandName;
  final String brandEmail;
  final String orderType;
  final double totalRating;
  final List<ItemReviewModel> itemReviews;
  final Timestamp? createdAt;
  final Timestamp? updatedAt;

  const Review({
    required this.id,
    required this.orderId,
    required this.userId,
    required this.userEmail,
    required this.userName,
    required this.brandName,
    required this.brandEmail,
    required this.orderType,
    required this.totalRating,
    required this.itemReviews,
    this.createdAt,
    this.updatedAt,
  });

  factory Review.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    return Review(
      id: doc.id,
      orderId: data['orderId'] ?? '',
      userId: data['userId'] ?? '',
      userEmail: data['userEmail'] ?? '',
      userName: data['userName'] ?? '',
      brandName: data['brandName'] ?? '',
      brandEmail: data['brandEmail'] ?? '',
      orderType: data['orderType'] ?? '',
      totalRating: (data['totalRating'] ?? 0.0).toDouble(),
      itemReviews: (data['itemReviews'] as List<dynamic>?)
              ?.map((item) => ItemReviewModel.fromMap(item as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: data['createdAt'] as Timestamp?,
      updatedAt: data['updatedAt'] as Timestamp?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'userId': userId,
      'userEmail': userEmail,
      'userName': userName,
      'brandName': brandName,
      'brandEmail': brandEmail,
      'orderType': orderType,
      'totalRating': totalRating,
      'itemReviews': itemReviews.map((item) => item.toMap()).toList(),
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': updatedAt ?? FieldValue.serverTimestamp(),
    };
  }

  String getFormattedDate() {
    if (createdAt == null) return '';
    final date = createdAt!.toDate();
    return '${date.day}/${date.month}/${date.year}';
  }

  String getTimeAgo() {
    if (createdAt == null) return '';
    final now = DateTime.now();
    final date = createdAt!.toDate();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}

class ItemReviewModel {
  final String itemId;
  final String itemName;
  final String itemNameEn;
  final String itemImage;
  final double rating;
  final String comment;

  const ItemReviewModel({
    required this.itemId,
    required this.itemName,
    required this.itemNameEn,
    required this.itemImage,
    required this.rating,
    required this.comment,
  });

  factory ItemReviewModel.fromMap(Map<String, dynamic> map) {
    return ItemReviewModel(
      itemId: map['itemId'] ?? '',
      itemName: map['itemName'] ?? '',
      itemNameEn: map['itemNameEn'] ?? '',
      itemImage: map['itemImage'] ?? '',
      rating: (map['rating'] ?? 0.0).toDouble(),
      comment: map['comment'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'itemName': itemName,
      'itemNameEn': itemNameEn,
      'itemImage': itemImage,
      'rating': rating,
      'comment': comment,
    };
  }

  String get displayName {
    // Use the appropriate language name
    return itemName.isNotEmpty ? itemName : itemNameEn;
  }
}