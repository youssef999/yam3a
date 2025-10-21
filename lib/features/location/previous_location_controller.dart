import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/core/utils/local_db.dart';

class PreviousLocationController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  bool isLoading = false;
  bool isDeleting = false;
  Map<String, dynamic>? locationData;

  @override
  void onInit() {
    super.onInit();
    loadLocationFromFirestore();
  }

  Future<void> loadLocationFromFirestore() async {
    try {
      isLoading = true;
      update();

      final userEmail = storage.userEmail;
      if (userEmail == null || userEmail.isEmpty) {
        Get.snackbar('error'.tr, 'user_email_required'.tr, snackPosition: SnackPosition.BOTTOM);
        isLoading = false;
        update();
        return;
      }

      final doc = await _firestore.collection('user_locations').doc(userEmail).get();

      if (doc.exists) {
        locationData = doc.data();
        if (kDebugMode) {
          print('📍 Loaded location from Firestore: ${locationData?['city']}');
        }
      } else {
        locationData = null;
        if (kDebugMode) {
          print('📍 No location found in Firestore');
        }
      }
    } catch (e) {
      Get.snackbar('error'.tr, 'failed_to_load_location'.tr, snackPosition: SnackPosition.BOTTOM);
      if (kDebugMode) {
        print('❌ Error loading location from Firestore: $e');
      }
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> deleteLocation() async {
    try {
      isDeleting = true;
      update();

      final userEmail = storage.userEmail;
      if (userEmail == null || userEmail.isEmpty) {
        Get.snackbar('error'.tr, 'user_email_required'.tr, snackPosition: SnackPosition.BOTTOM);
        isDeleting = false;
        update();
        return;
      }

      // Delete from Firestore
      await _firestore.collection('user_locations').doc(userEmail).delete();

      // Clear from local storage
      await storage.saveUserCountry('');
      await storage.saveUserCity('');
      await storage.saveUserLocationName('');
      await storage.saveUserFullAddress('');

      Get.snackbar('success'.tr, 'location_deleted_successfully'.tr, snackPosition: SnackPosition.BOTTOM);

      if (kDebugMode) {
        print('✅ Location deleted successfully');
      }

      locationData = null;
      update();

      // Navigate back after deletion
      Get.back();
    } catch (e) {
      Get.snackbar('error'.tr, 'failed_to_delete_location'.tr, snackPosition: SnackPosition.BOTTOM);
      if (kDebugMode) {
        print('❌ Error deleting location: $e');
      }
    } finally {
      isDeleting = false;
      update();
    }
  }

  String getFullAddress() {
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
    
    if (locationData!['country'] != null) {
      parts.add(locationData!['country']);
    }

    return parts.isEmpty ? 'no_address_available'.tr : parts.join(', ');
  }

  String getCoordinates() {
    if (locationData == null) return 'no_coordinates_available'.tr;
    
    final lat = locationData!['latitude'];
    final lng = locationData!['longitude'];
    
    if (lat == null || lng == null) return 'no_coordinates_available'.tr;
    
    return '${lat.toStringAsFixed(6)}, ${lng.toStringAsFixed(6)}';
  }
}
