import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/utils/local_db.dart';
import 'package:shop_app/features/orders/order_model.dart';
import 'package:shop_app/features/orders/orders_controller.dart';

class SendReviewController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final OrderModel order;
  
  SendReviewController({required this.order});

  bool isLoading = false;
  bool isSubmittingReview = false;
  String? errorMessage;
  
  // Review data for each item
  List<ItemReview> itemReviews = [];
  
  @override
  void onInit() {
    super.onInit();
    _initializeItemReviews();
  }

  void _initializeItemReviews() {
    itemReviews = order.items.map((item) => ItemReview(
      itemId: item.id,
      itemName: item.name,
      itemNameEn: item.nameEn,
      itemImage: item.image,
      rating: 5.0, // Default to 5 stars
      comment: '',
    )).toList();
    update();
  }

  void updateItemRating(String itemId, double rating) {
    final index = itemReviews.indexWhere((review) => review.itemId == itemId);
    if (index != -1) {
      itemReviews[index].rating = rating;
      update();
    }
  }

  void updateItemComment(String itemId, String comment) {
    final index = itemReviews.indexWhere((review) => review.itemId == itemId);
    if (index != -1) {
      itemReviews[index].comment = comment;
      update();
    }
  }

  double get averageRating {
    if (itemReviews.isEmpty) return 0.0;
    double total = itemReviews.fold(0.0, (sum, review) => sum + review.rating);
    return total / itemReviews.length;
  }

  bool get canSubmitReview {
    // Check if all items have been rated and commented
    return itemReviews.every((review) => 
      review.rating > 0 && review.comment.trim().isNotEmpty
    );
  }

  Future<bool> submitReview() async {
    if (!canSubmitReview) {
      Get.snackbar(
        'error'.tr,
        'please_rate_and_comment_all_items'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    try {
      isSubmittingReview = true;
      update();

      // Get user data from local storage
      final userData = _getUserDataFromLocal();
      if (userData == null) {
        throw Exception('User data not found');
      }

      // Create review document
      final reviewData = {
        'orderId': order.id,
        'userId': userData['userId'],
        'userEmail': userData['userEmail'],
        'userName': userData['userName'],
        'brandName': order.brandName,
        'brandEmail': order.brandEmail,
        'orderType': order.orderType,
        'totalRating': averageRating,
        'itemReviews': itemReviews.map((review) => review.toMap()).toList(),
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

      // Save review to reviews collection
      final reviewDoc = await _firestore.collection('reviews').add(reviewData);

      if (kDebugMode) {
        print('✅ Review saved with ID: ${reviewDoc.id}');
        print('📊 Average rating: $averageRating');
        print('🏢 Brand: ${order.brandName}');
      }

      // Update brand rating
      await _updateBrandRating();

      Get.snackbar(
        'success'.tr,
        'review_submitted_successfully'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Refresh orders list to update review status
      try {
        final ordersController = Get.find<OrdersController>();
        ordersController.refreshOrders();
      } catch (e) {
        // OrdersController might not be available, that's okay
        if (kDebugMode) {
          print('ℹ️ OrdersController not found, skipping refresh');
        }
      }

      return true;

    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('❌ Failed to submit review: $e');
        print('📋 Stack trace: $stackTrace');
      }
      
      Get.snackbar(
        'error'.tr,
        'failed_to_submit_review'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      
      return false;
    } finally {
      isSubmittingReview = false;
      update();
    }
  }

  Map<String, String>? _getUserDataFromLocal() {
    final userEmail = storage.userEmail;
    final userName = storage.userName;
    
    if (userEmail == null || userName == null) {
      if (kDebugMode) {
        print('❌ User data not found in local storage');
      }
      return null;
    }

    return {
      'userId': userEmail, // Using email as user ID for now
      'userEmail': userEmail,
      'userName': userName,
    };
  }

  Future<void> _updateBrandRating() async {
    try {
      // Get all reviews for this brand
      final reviewsSnapshot = await _firestore
          .collection('reviews')
          .where('brandName', isEqualTo: order.brandName)
          .get();

      if (reviewsSnapshot.docs.isEmpty) {
        if (kDebugMode) {
          print('⚠️ No reviews found for brand: ${order.brandName}');
        }
        return;
      }

      // Calculate average rating
      double totalRating = 0.0;
      int reviewCount = 0;

      for (final doc in reviewsSnapshot.docs) {
        final data = doc.data();
        final rating = (data['totalRating'] ?? 0.0).toDouble();
        totalRating += rating;
        reviewCount++;
      }

      final averageRating = reviewCount > 0 ? totalRating / reviewCount : 0.0;

      if (kDebugMode) {
        print('📊 Brand ${order.brandName} stats:');
        print('   Total reviews: $reviewCount');
        print('   Average rating: ${averageRating.toStringAsFixed(2)}');
      }

      // Update brand document
      final brandQuery = await _firestore
          .collection('brands')
          .where('name', isEqualTo: order.brandName)
          .limit(1)
          .get();

      if (brandQuery.docs.isNotEmpty) {
        final brandDoc = brandQuery.docs.first;
        await brandDoc.reference.update({
          'rating': averageRating,
          'reviewCount': reviewCount,
          'updatedAt': FieldValue.serverTimestamp(),
        });

        if (kDebugMode) {
          print('✅ Brand rating updated successfully');
        }
      } else {
        if (kDebugMode) {
          print('⚠️ Brand document not found: ${order.brandName}');
        }
      }

    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('❌ Failed to update brand rating: $e');
        print('📋 Stack trace: $stackTrace');
      }
    }
  }
}

class ItemReview {
  final String itemId;
  final String itemName;
  final String itemNameEn;
  final String itemImage;
  double rating;
  String comment;

  ItemReview({
    required this.itemId,
    required this.itemName,
    required this.itemNameEn,
    required this.itemImage,
    this.rating = 5.0,
    this.comment = '',
  });

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

  factory ItemReview.fromMap(Map<String, dynamic> map) {
    return ItemReview(
      itemId: map['itemId'] ?? '',
      itemName: map['itemName'] ?? '',
      itemNameEn: map['itemNameEn'] ?? '',
      itemImage: map['itemImage'] ?? '',
      rating: (map['rating'] ?? 5.0).toDouble(),
      comment: map['comment'] ?? '',
    );
  }
}