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
  double totalPrice = 0.0; // This will be the paid amount (minimum order considered)
  double actualTotalPrice = 0.0; // Original order total before minimum adjustment
  String brandName = '';
  String brandEmail = '';
  String brandImage = '';
  DateTime? receiveDate;
  
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
    double? actualOrderTotal, // Original order total before minimum adjustment
    DateTime? selectedReceiveDate,
  }) {
    orderType = type;
    items = orderItems;
    totalPrice = price; // This is the paid amount (minimum order considered)
    actualTotalPrice = actualOrderTotal ?? price; // Original total or same as paid amount
    brandName = brand;
    brandEmail = email;
    brandImage = image;
    receiveDate = selectedReceiveDate;
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
      
      if (kDebugMode) {
        print('🔍 Processing order items:');
        print('Order Type: $orderType');
        print('Items count: ${items.length}');
        print('Items: $items');
      }
      
      if (orderType.toUpperCase() == 'SERVICE') {
        for (var item in items) {
          if (item is Service) {
            final serviceData = item.toMap();
            itemsData.add(serviceData);
            if (kDebugMode) {
              print('✅ Added service: ${serviceData['name']} (ID: ${serviceData['id']})');
            }
          } else {
            if (kDebugMode) {
              print('❌ Item is not a Service: ${item.runtimeType}');
            }
          }
        }
      } else if (orderType.toUpperCase() == 'PACKAGE') {
        for (var item in items) {
          if (item is Package) {
            final packageData = item.toMap();
            itemsData.add(packageData);
            if (kDebugMode) {
              print('✅ Added package: ${packageData['name']} (ID: ${packageData['id']})');
            }
          } else {
            if (kDebugMode) {
              print('❌ Item is not a Package: ${item.runtimeType}');
            }
          }
        }
      }
      
      if (kDebugMode) {
        print('📦 Final items data count: ${itemsData.length}');
        if (itemsData.isNotEmpty) {
          print('First item: ${itemsData.first}');
        }
      }
      
      // Validate that we have items to order
      if (itemsData.isEmpty) {
        if (kDebugMode) {
          print('❌ No items found to place order');
        }
        Get.snackbar('error'.tr, 'no_items_selected'.tr, snackPosition: SnackPosition.BOTTOM);
        return false;
      }
      
      // Calculate unpaid amount (difference between actual total and paid amount)
      final unpaidAmount = actualTotalPrice > totalPrice ? actualTotalPrice - totalPrice : 0.0;
      
      final orderData = {
        'userId': userEmail,
        'userEmail': userEmail,
        'userName': userName,
        'orderType': orderType,
        'orderDate': DateTime.now().toIso8601String(),
        'receiveDate': receiveDate?.toIso8601String(),
        'totalPrice': actualTotalPrice, // Actual order total
        'paidAmount': totalPrice, // Amount customer pays (minimum order consideration)
        'unpaidAmount': unpaidAmount, // Difference (remaining balance)
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
        print('✅ Order placed successfully');
        print('💳 Payment: ${selectedPaymentMethod == PaymentMethod.cash ? "Cash" : "Visa"}');
        print('💰 Actual Total: BD $actualTotalPrice');
        print('💵 Paid Amount: BD $totalPrice');
        print('💸 Unpaid Amount: BD ${actualTotalPrice - totalPrice}');
        print('📦 Items saved: ${itemsData.length}');
        for (int i = 0; i < itemsData.length; i++) {
          final item = itemsData[i];
          print('   ${i + 1}. ${item['name']} (${item['nameEn']}) - ID: ${item['id']} - BD ${item['price']}');
        }
        if (receiveDate != null) {
          print('📅 Receive Date: ${receiveDate!.toIso8601String()}');
        }
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
