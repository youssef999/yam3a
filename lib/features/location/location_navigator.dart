import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/utils/local_db.dart';
import 'package:shop_app/features/location/location_view.dart';
import 'package:shop_app/features/location/previous_location_view.dart';

/// Helper class to navigate to the appropriate location screen
class LocationNavigator {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Navigate to location screen (previous or new) based on whether user has saved location
  static Future<void> navigateToLocationScreen() async {
    try {
      final userEmail = storage.userEmail;
      
      if (userEmail == null || userEmail.isEmpty) {
        if (kDebugMode) {
          print('⚠️ No user email found, navigating to location view');
        }
        Get.to(() => const LocationView());
        return;
      }

      // Check if user has location in Firestore
      final doc = await _firestore.collection('user_locations').doc(userEmail).get();
      
      if (doc.exists && doc.data() != null) {
        if (kDebugMode) {
          print('📍 User has saved location, navigating to previous location view');
        }
        Get.to(() => const PreviousLocationView());
      } else {
        if (kDebugMode) {
          print('📍 No saved location found, navigating to location view');
        }
        Get.to(() => const LocationView());
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error checking location: $e');
      }
      // On error, navigate to location view as fallback
      Get.to(() => const LocationView());
    }
  }

  /// Check if user has a saved location (without navigation)
  static Future<bool> hasLocationSaved() async {
    try {
      final userEmail = storage.userEmail;
      
      if (userEmail == null || userEmail.isEmpty) {
        return false;
      }

      final doc = await _firestore.collection('user_locations').doc(userEmail).get();
      return doc.exists && doc.data() != null;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error checking location: $e');
      }
      return false;
    }
  }
}
