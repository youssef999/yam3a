

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/core/utils/local_db.dart';

class PaymentController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  final double totalMoney;
  final String? orderId;
  final Map<String, dynamic>? userData;
  final Map<String, dynamic>? sellerData;

  // Commission rates
  static const double appCommissionRate = 0.02; // 2%
  static const double bankFeeRate = 0.005; // 0.5%
  static const double vendorProfitRate = 0.975; // 97.5%

  // Calculated amounts
  late double appCommission;
  late double bankFee;
  late double vendorProfit;
  
  // Payment processing status
  bool isProcessing = false;
  bool isSaved = false;

  PaymentController({
    required this.totalMoney,
    this.orderId,
    this.userData,
    this.sellerData,
  }) {
    calculatePaymentBreakdown();
  }

  /// Calculate all payment breakdown components
  void calculatePaymentBreakdown() {
    appCommission = totalMoney * appCommissionRate;
    bankFee = totalMoney * bankFeeRate;
    vendorProfit = totalMoney * vendorProfitRate;
    
    // Print the breakdown
    printPaymentBreakdown();
    
    // Automatically save to Firestore if order data is provided
    if (orderId != null) {
      savePaymentBreakdownToFirestore();
    }
  }

  /// Save payment breakdown to Firestore
  Future<bool> savePaymentBreakdownToFirestore() async {
    if (isProcessing || isSaved) {
      print('Payment breakdown already processing or saved');
      return isSaved;
    }

    try {
      isProcessing = true;
      update();

      // Get user data from local storage if not provided
      final currentUserData = userData ?? await _getUserDataFromLocal();
      final currentSellerData = sellerData ?? {'name': 'Unknown Seller', 'email': 'unknown@seller.com'};

      if (kDebugMode) {
        print('📋 Processing payment with data:');
        print('User: ${currentUserData['name']} (${currentUserData['email']})');
        print('Brand: ${currentSellerData['name'] ?? currentSellerData['brandName']} (${currentSellerData['email'] ?? currentSellerData['brandEmail']})');
      }

      final paymentData = {
        // Order info
        'orderId': orderId,
        'totalPrice': totalMoney,
        'paymentDate': DateTime.now().toIso8601String(),
        'createdAt': FieldValue.serverTimestamp(),
        
        // User data (from local_db)
        'userName': currentUserData['name'] ?? 'Unknown User',
        'userEmail': currentUserData['email'] ?? 'unknown@user.com',
        
        // Seller/Brand data
        'brandName': currentSellerData['name'] ?? currentSellerData['brandName'] ?? 'Unknown Brand',
        'brandEmail': currentSellerData['email'] ?? currentSellerData['brandEmail'] ?? 'unknown@brand.com',
        
        // Payment breakdown
        'appCommission': appCommission,
        'bankFee': bankFee,
        'vendorProfit': vendorProfit,
      };

      // Save to Firestore payments collection with generated document ID
      final docRef = await _firestore.collection('payments').add(paymentData);
      
      print('✅ Payment saved to Firestore with ID: ${docRef.id}');
      print('👤 User: ${currentUserData['name']} (${currentUserData['email']})');
      print('🏪 Brand: ${currentSellerData['name'] ?? currentSellerData['brandName']} (${currentSellerData['email'] ?? currentSellerData['brandEmail']})');
      print('💵 Total: BD ${totalMoney.toStringAsFixed(2)}');
      print('🏛️ App Commission (2%): BD ${appCommission.toStringAsFixed(2)}');
      print('🏦 Bank Fee (0.5%): BD ${bankFee.toStringAsFixed(2)}');
      print('👨‍💼 Vendor Profit (97.5%): BD ${vendorProfit.toStringAsFixed(2)}');

      isSaved = true;
      return true;
      
    } catch (e) {
      print('❌ Error saving payment breakdown to Firestore: $e');
      return false;
    } finally {
      isProcessing = false;
      update();
    }
  }

  /// Get user data from local storage using local_db
  Future<Map<String, dynamic>> _getUserDataFromLocal() async {
    if (kDebugMode) {
      print('📱 Getting user data from local_db:');
      print('Name: ${storage.userName}');
      print('Email: ${storage.userEmail}');
    }
    
    return {
      'name': storage.userName ?? 'Unknown User',
      'email': storage.userEmail ?? 'unknown@user.com',
    };
  }

  /// Print payment breakdown
  void printPaymentBreakdown() {
    print('\n=== PAYMENT BREAKDOWN ===');
    print('Total: BD ${totalMoney.toStringAsFixed(2)}');
    print('App Commission (2%): BD ${appCommission.toStringAsFixed(2)}');
    print('Bank Fee (0.5%): BD ${bankFee.toStringAsFixed(2)}');
    print('Vendor Profit (97.5%): BD ${vendorProfit.toStringAsFixed(2)}');
    print('========================\n');
  }

  /// Manually save payment breakdown (useful for testing or retry scenarios)
  Future<bool> savePaymentData() async {
    return await savePaymentBreakdownToFirestore();
  }

  /// Reset the payment controller state
  void reset() {
    isProcessing = false;
    isSaved = false;
    appCommission = 0.0;
    bankFee = 0.0;
    vendorProfit = 0.0;
    update();
  }



  @override
  void onInit() {
    super.onInit();
    print('PaymentController initialized with total: \$${totalMoney.toStringAsFixed(2)}');
  }

  @override
  void onClose() {
    print('PaymentController disposed');
    super.onClose();
  }
}