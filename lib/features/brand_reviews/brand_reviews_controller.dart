import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/models/brand.dart';
import 'package:shop_app/core/models/review.dart';

class BrandReviewsController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Brand brand;
  
  BrandReviewsController({required this.brand});

  List<Review> reviews = [];
  bool isLoading = false;
  bool hasError = false;
  String? errorMessage;
  
  // Statistics
  int totalReviews = 0;
  double averageRating = 0.0;
  Map<int, int> ratingDistribution = {
    5: 0,
    4: 0,
    3: 0,
    2: 0,
    1: 0,
  };

  @override
  void onInit() {
    super.onInit();
    fetchBrandReviews();
  }

  Future<void> fetchBrandReviews() async {
    try {
      isLoading = true;
      hasError = false;
      errorMessage = null;
      update();

      final snapshot = await _firestore
          .collection('reviews')
          .where('brandName', isEqualTo: brand.name)
          .orderBy('createdAt', descending: true)
          .get();

      reviews = snapshot.docs.map((doc) => Review.fromFirestore(doc)).toList();
      
      _calculateStatistics();

      if (kDebugMode) {
        print('📊 Fetched ${reviews.length} reviews for brand: ${brand.name}');
        print('⭐ Average rating: ${averageRating.toStringAsFixed(1)}');
      }

    } catch (e, stackTrace) {
      hasError = true;
      errorMessage = e.toString();
      
      if (kDebugMode) {
        print('❌ Failed to fetch brand reviews: $e');
        print('📋 Stack trace: $stackTrace');
      }
    } finally {
      isLoading = false;
      update();
    }
  }

  void _calculateStatistics() {
    if (reviews.isEmpty) {
      totalReviews = 0;
      averageRating = brand.rating; // Use brand's stored rating if no reviews
      ratingDistribution = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
      return;
    }

    totalReviews = reviews.length;
    
    // Calculate average rating
    double totalRating = 0.0;
    ratingDistribution = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    
    for (final review in reviews) {
      totalRating += review.totalRating;
      
      // Count rating distribution
      final roundedRating = review.totalRating.round();
      if (roundedRating >= 1 && roundedRating <= 5) {
        ratingDistribution[roundedRating] = (ratingDistribution[roundedRating] ?? 0) + 1;
      }
    }
    
    averageRating = totalRating / totalReviews;
  }

  Future<void> refreshReviews() async {
    await fetchBrandReviews();
  }

  List<Review> get sortedReviews {
    final sortedList = List<Review>.from(reviews);
    sortedList.sort((a, b) {
      if (a.createdAt == null && b.createdAt == null) return 0;
      if (a.createdAt == null) return 1;
      if (b.createdAt == null) return -1;
      return b.createdAt!.compareTo(a.createdAt!);
    });
    return sortedList;
  }

  double getRatingPercentage(int stars) {
    if (totalReviews == 0) return 0.0;
    return ((ratingDistribution[stars] ?? 0) / totalReviews) * 100;
  }

  String get ratingText {
    if (averageRating == 0.0) return 'no_ratings_yet'.tr;
    return averageRating.toStringAsFixed(1);
  }

  String get reviewCountText {
    if (totalReviews == 0) return 'no_reviews'.tr;
    if (totalReviews == 1) return '1 ${'review'.tr}';
    return '$totalReviews ${'reviews'.tr}';
  }

  bool get hasReviews => reviews.isNotEmpty;
}