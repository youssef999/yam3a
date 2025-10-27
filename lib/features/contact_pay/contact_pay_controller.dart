import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ContactPayController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Premium mode data
  double premiumPrice = 0.0;
  bool isLoadingPrice = false;
  String? errorMessage;
  
  // Document ID for premium mode
  static const String premiumDocId = 'gDBlPcN5G7n7RpVd2bn5';
  
  @override
  void onInit() {
    super.onInit();
    fetchPremiumPrice();
  }
  
  /// Fetch premium price from Firestore
  Future<void> fetchPremiumPrice() async {
    try {
      isLoadingPrice = true;
      errorMessage = null;
      update();
      
      if (kDebugMode) {
        print('🔍 Fetching premium price from document: $premiumDocId');
      }
      
      final docSnapshot = await _firestore
          .collection('app_premuim_mode')
          .doc(premiumDocId)
          .get();
      
      if (docSnapshot.exists && docSnapshot.data() != null) {
        final data = docSnapshot.data()!;
        premiumPrice = (data['price'] ?? 0.0).toDouble();
        
        if (kDebugMode) {
          print('✅ Premium price fetched successfully: BD ${premiumPrice.toStringAsFixed(2)}');
          print('📄 Document data: $data');
        }
      } else {
        premiumPrice = 0.0;
        errorMessage = 'Premium pricing not available';
        
        if (kDebugMode) {
          print('❌ Premium price document not found');
        }
      }
      
    } catch (e, stackTrace) {
      premiumPrice = 0.0;
      errorMessage = 'Failed to load premium price';
      
      if (kDebugMode) {
        print('💥 Error fetching premium price: $e');
        debugPrint(stackTrace.toString());
      }
    } finally {
      isLoadingPrice = false;
      update();
    }
  }
  
  /// Refresh premium price data
  Future<void> refreshPremiumPrice() async {
    await fetchPremiumPrice();
  }
  
  /// Get formatted price string
  String get formattedPrice {
    if (isLoadingPrice) return 'Loading...';
    if (errorMessage != null) return 'N/A';
    return 'BD ${premiumPrice.toStringAsFixed(2)}';
  }
  
  /// Get price per month
  String get monthlyPrice {
    if (isLoadingPrice || errorMessage != null) return formattedPrice;
    return 'BD ${premiumPrice.toStringAsFixed(2)}/month';
  }
  
  /// Check if premium price is available
  bool get isPriceAvailable {
    return !isLoadingPrice && errorMessage == null && premiumPrice > 0;
  }
  
  @override
  void onClose() {
    if (kDebugMode) {
      print('ContactPayController disposed');
    }
    super.onClose();
  }
}
