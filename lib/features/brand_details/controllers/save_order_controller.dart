

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/models/service.dart';
import 'package:shop_app/core/models/package.dart';
import 'package:shop_app/core/utils/local_db.dart';

class SaveOrderController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = false;

  /// Save order to Firestore
  /// [orderType] should be 'service' or 'package'
  /// [items] should be List<Service> or List<Package>
  /// [brandName], [brandEmail], [brandImage] are brand information
  /// [totalPrice] is the actual order total, [paidAmount] is what customer pays (minimum order consideration)
  /// [receiveDate] is when the customer wants to receive the order
  Future<bool> saveOrder({
    required String orderType,
    required List<dynamic> items,
    required double totalPrice,
    required double paidAmount,
    required String brandName,
    required String brandEmail,
    required String brandImage,
    DateTime? receiveDate,
    String? notes,
  }) async {
    try {
      isLoading = true;
      update();

      // Get user data from local storage
      final userEmail = storage.userEmail ?? 'guest@example.com';
      final userName = storage.userName ?? 'Guest User';
      final userCountry = storage.userCountry;
      final userCity = storage.userCity;
      final userLatitude = storage.userLatitude;
      final userLongitude = storage.userLongitude;
      final userLocationName = storage.userLocationName;
      final userFullAddress = storage.userFullAddress;

      // Convert items to map format
      final List<Map<String, dynamic>> itemsData = [];
      
      if (kDebugMode) {
        print('🔍 Processing order items in SaveOrderController:');
        print('Order Type: $orderType');
        print('Items count: ${items.length}');
      }
      
      if (orderType.toLowerCase() == 'service') {
        for (var item in items) {
          if (item is Service) {
            final serviceData = item.toMap();
            itemsData.add(serviceData);
            if (kDebugMode) {
              print('✅ Added service: ${serviceData['name']} (ID: ${serviceData['id']})');
            }
          }
        }
      } else if (orderType.toLowerCase() == 'package') {
        for (var item in items) {
          if (item is Package) {
            final packageData = item.toMap();
            itemsData.add(packageData);
            if (kDebugMode) {
              print('✅ Added package: ${packageData['name']} (ID: ${packageData['id']})');
            }
          }
        }
      }
      
      // Validate that we have items to order
      if (itemsData.isEmpty) {
        if (kDebugMode) {
          print('❌ No items found to save order');
        }
        Get.snackbar('error'.tr, 'no_items_selected'.tr, snackPosition: SnackPosition.BOTTOM);
        return false;
      }

      // Calculate unpaid amount (difference between actual total and paid amount)
      final unpaidAmount = totalPrice > paidAmount ? totalPrice - paidAmount : 0.0;
      
      // Create order object
      final orderData = {
        'userId': userEmail, // Using email as userId for now
        'userEmail': userEmail,
        'userName': userName,
        'orderType': orderType,
        'orderDate': DateTime.now().toIso8601String(),
        'receiveDate': receiveDate?.toIso8601String(),
        'totalPrice': totalPrice, // Actual order total
        'paidAmount': paidAmount, // Amount customer pays (minimum order consideration)
        'unpaidAmount': unpaidAmount, // Difference (remaining balance)
        'status': 'pending',
        'userCountry': userCountry,
        'userCity': userCity,
        'userLatitude': userLatitude,
        'userLongitude': userLongitude,
        'userLocationName': userLocationName,
        'userFullAddress': userFullAddress,
        'brandName': brandName,
        'brandEmail': brandEmail,
        'brandImage': brandImage,
        'items': itemsData,
        'notes': notes,
        'createdAt': FieldValue.serverTimestamp(),
      };

      // Save to Firestore
      final docRef = await _firestore.collection('orders').add(orderData);

      if (kDebugMode) {
        print('✅ Order saved successfully with ID: ${docRef.id}');
        print('📦 Order type: $orderType');
        print('💰 Total price: BD $totalPrice');
        print('� Paid amount: BD $paidAmount');
        print('💸 Unpaid amount: BD $unpaidAmount');
        print('�📝 Items count: ${itemsData.length}');
      }

      // Show success message
      Get.snackbar(
        'success'.tr,
        'order_placed_successfully'.tr,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );

      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error saving order: $e');
      }

      // Show error message
      Get.snackbar(
        'error'.tr,
        'failed_to_place_order'.tr,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );

      return false;
    } finally {
      isLoading = false;
      update();
    }
  }

  /// Simplified checkout function for services
  Future<bool> checkoutServices({
    required List<Service> services,
    required double totalPrice,
    required double paidAmount,
    required String brandName,
    required String brandEmail,
    required String brandImage,
    DateTime? receiveDate,
    String? notes,
  }) async {
    return await saveOrder(
      orderType: 'service',
      items: services,
      totalPrice: totalPrice,
      paidAmount: paidAmount,
      brandName: brandName,
      brandEmail: brandEmail,
      brandImage: brandImage,
      receiveDate: receiveDate,
      notes: notes,
    );
  }

  /// Simplified checkout function for packages
  Future<bool> checkoutPackages({
    required List<Package> packages,
    required double totalPrice,
    required double paidAmount,
    required String brandName,
    required String brandEmail,
    required String brandImage,
    DateTime? receiveDate,
    String? notes,
  }) async {
    return await saveOrder(
      orderType: 'package',
      items: packages,
      totalPrice: totalPrice,
      paidAmount: paidAmount,
      brandName: brandName,
      brandEmail: brandEmail,
      brandImage: brandImage,
      receiveDate: receiveDate,
      notes: notes,
    );
  }
}
