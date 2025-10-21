import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/models/service.dart';
import 'package:shop_app/core/models/package.dart';
import 'package:shop_app/core/utils/local_db.dart';

enum PaymentMethod { cash, visa }

class CheckoutController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  String orderType = ''; 
  List<dynamic> items = [];
  double totalPrice = 0.0;
  String brandName = '';
  String brandEmail = '';
  String brandImage = '';
  
  Map<String, dynamic>? locationData;
  PaymentMethod selectedPaymentMethod = PaymentMethod.cash;
  bool isLoading = false;
  bool isLoadingLocation = false;
  
  @override
  void onInit() {
    super.onInit();
    loadLocationData();
  }
  
  void initializeCheckout({
    required String type,
    required List<dynamic> orderItems,
    required double price,
    required String brand,
    required String email,
    required String image,
  }) {
    orderType = type;
    items = orderItems;
    totalPrice = price;
    brandName = brand;
    brandEmail = email;
    brandImage = image;
    update();
  }
  
  Future<void> loadLocationData() async {
    try {
      isLoadingLocation = true;
      update();
      
      final userEmail = storage.userEmail;
      if (userEmail == null || userEmail.isEmpty) {
        isLoadingLocation = false;
        update();
        return;
      }
      
      final doc = await _firestore.collection('user_locations').doc(userEmail).get();
      
      if (doc.exists) {
        locationData = doc.data();
        if (kDebugMode) {
          print('Location loaded: ${locationData?['city']}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading location: $e');
      }
    } finally {
      isLoadingLocation = false;
      update();
    }
  }
  
  void selectPaymentMethod(PaymentMethod method) {
    selectedPaymentMethod = method;
    update();
  }
  
  String getFormattedAddress() {
    if (locationData == null) return 'no_address_available'.tr;
    
    final parts = <String>[];
    
    if (locationData!['apartment'] != null && locationData!['apartment'].toString().isNotEmpty) {
      parts.add('${'apartment'.tr} ${locationData!['apartment']}');
    }
    
    if (locationData!['floor'] != null && locationData!['floor'].toString().isNotEmpty) {
      parts.add('${'floor'.tr} ${locationData!['floor']}');
    }
    
    if (locationData!['area'] != null && locationData!['area'].toString().isNotEmpty) {
      parts.add(locationData!['area']);
    }
    
    if (locationData!['city'] != null) {
      parts.add(locationData!['city']);
    }
    
    return parts.isEmpty ? 'no_address_available'.tr : parts.join(', ');
  }
  
  String getPhoneNumber() {
    if (locationData == null) return 'not_set'.tr;
    return locationData!['phone']?.toString() ?? 'not_set'.tr;
  }
  
  Future<bool> placeOrder() async {
    if (locationData == null) {
      Get.snackbar('error'.tr, 'location_data_required'.tr, snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    
    try {
      isLoading = true;
      update();
      
      final userEmail = storage.userEmail ?? 'guest@example.com';
      final userName = storage.userName ?? 'Guest User';
      
      final List<Map<String, dynamic>> itemsData = [];
      
      if (orderType == 'service') {
        for (var item in items) {
          if (item is Service) {
            itemsData.add(item.toMap());
          }
        }
      } else if (orderType == 'package') {
        for (var item in items) {
          if (item is Package) {
            itemsData.add(item.toMap());
          }
        }
      }
      
      final orderData = {
        'userId': userEmail,
        'userEmail': userEmail,
        'userName': userName,
        'orderType': orderType,
        'orderDate': DateTime.now().toIso8601String(),
        'totalPrice': totalPrice,
        'status': 'pending',
        'paymentMethod': selectedPaymentMethod == PaymentMethod.cash ? 'cash' : 'visa',
        'paymentStatus': selectedPaymentMethod == PaymentMethod.cash ? 'pending' : 'completed',
        'deliveryLocation': {
          'country': locationData!['country'],
          'city': locationData!['city'],
          'area': locationData!['area'],
          'floor': locationData!['floor'],
          'apartment': locationData!['apartment'],
          'phone': locationData!['phone'],
          'fullAddress': locationData!['fullAddress'],
          'latitude': locationData!['latitude'],
          'longitude': locationData!['longitude'],
        },
        'brandName': brandName,
        'brandEmail': brandEmail,
        'brandImage': brandImage,
        'items': itemsData,
        'itemsCount': itemsData.length,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };
      
      await _firestore.collection('orders').add(orderData);
      
      if (kDebugMode) {
        print('Order placed successfully');
        print('Payment: ${selectedPaymentMethod == PaymentMethod.cash ? "Cash" : "Visa"}');
        print('Total: BD $totalPrice');
      }
      
      Get.snackbar('success'.tr, 'order_placed_successfully'.tr, snackPosition: SnackPosition.BOTTOM);
      
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error placing order: $e');
      }
      
      Get.snackbar('error'.tr, 'failed_to_place_order'.tr, snackPosition: SnackPosition.BOTTOM);
      
      return false;
    } finally {
      isLoading = false;
      update();
    }
  }
  
  String getPaymentMethodName() {
    return selectedPaymentMethod == PaymentMethod.cash ? 'cash_on_delivery'.tr : 'visa_card'.tr;
  }
  
  String getPaymentMethodIcon() {
    return selectedPaymentMethod == PaymentMethod.cash ? '💵' : '💳';
  }
}
