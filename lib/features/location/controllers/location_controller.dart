import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/core/utils/local_db.dart';

class LocationController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  final areaController = TextEditingController();
  final floorController = TextEditingController();
  final apartmentController = TextEditingController();
  final notesController = TextEditingController();
  final phoneController = TextEditingController();

  String? selectedCity;
  double? latitude;
  double? longitude;
  bool isLoading = false;
  bool isLoadingSavedLocation = false;
  bool hasExistingLocation = false;

  final List<String> citiesKeys = [
    'city_manama',
    'city_riffa',
    'city_muharraq',
    'city_hamad_town',
    'city_aali',
    'city_isa_town',
    'city_sitra',
    'city_budaiya',
    'city_jidhafs',
    'city_al_malikiyah',
    'city_sanabis',
    'city_tubli',
    'city_dar_kulaib',
    'city_hidd',
    'city_al_markh',
    'city_sanad',
  ];

  @override
  void onInit() {
    super.onInit();
    loadSavedLocation();
  }

  @override
  void onClose() {
    areaController.dispose();
    floorController.dispose();
    apartmentController.dispose();
    notesController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> loadSavedLocation() async {
    try {
      isLoadingSavedLocation = true;
      update();

      final savedCity = storage.userCity;
      final savedLat = storage.userLatitude;
      final savedLng = storage.userLongitude;
      final savedLocationName = storage.userLocationName;

      if (savedCity != null && savedLat != null && savedLng != null) {
        hasExistingLocation = true;
        
        // Check if savedCity is already a valid key
        if (citiesKeys.contains(savedCity)) {
          selectedCity = savedCity;
        } else {
          // Find the city key that matches the saved translated city name
          String? cityKey;
          for (var key in citiesKeys) {
            if (key.tr == savedCity) {
              cityKey = key;
              break;
            }
          }
          selectedCity = cityKey;
        }
        
        latitude = savedLat;
        longitude = savedLng;
        if (savedLocationName != null) areaController.text = savedLocationName;

        if (kDebugMode) {
          print('📍 Loaded existing location: $savedCity (resolved key: $selectedCity)');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error loading saved location: $e');
      }
    } finally {
      isLoadingSavedLocation = false;
      update();
    }
  }

  void selectCity(String? cityKey) {
    selectedCity = cityKey;
    update();
  }

  Future<void> getCurrentLocation() async {
    try {
      isLoading = true;
      update();

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar('error'.tr, 'location_permission_denied'.tr, snackPosition: SnackPosition.BOTTOM);
          isLoading = false;
          update();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar('error'.tr, 'location_permission_denied_forever'.tr, snackPosition: SnackPosition.BOTTOM);
        isLoading = false;
        update();
        return;
      }

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar('error'.tr, 'location_services_disabled'.tr, snackPosition: SnackPosition.BOTTOM);
        isLoading = false;
        update();
        return;
      }

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      latitude = position.latitude;
      longitude = position.longitude;

      Get.snackbar('success'.tr, 'your_location_detected_success'.tr, snackPosition: SnackPosition.BOTTOM);

      if (kDebugMode) {
        print('📍 Location detected: $latitude, $longitude');
      }
    } catch (e) {
      Get.snackbar('error'.tr, 'location_error'.tr, snackPosition: SnackPosition.BOTTOM);
      if (kDebugMode) {
        print('❌ Error getting location: $e');
      }
    } finally {
      isLoading = false;
      update();
    }
  }

  bool validateForm() {
    if (selectedCity == null || selectedCity!.isEmpty) {
      Get.snackbar('error'.tr, 'please_select_city'.tr);
      return false;
    }

    if (latitude == null || longitude == null) {
      Get.snackbar('error'.tr, 'please_detect_location_first'.tr);
      return false;
    }

    if (areaController.text.trim().isEmpty) {
      Get.snackbar('error'.tr, 'area_is_required'.tr);
      return false;
    }

    if (phoneController.text.trim().isEmpty) {
      Get.snackbar('error'.tr, 'phone_is_required'.tr);
      return false;
    }

    return true;
  }

  Future<bool> saveLocation() async {
    if (!validateForm()) return false;

    try {
      isLoading = true;
      update();

      final userEmail = storage.userEmail;
      if (userEmail == null || userEmail.isEmpty) {
        Get.snackbar('error'.tr, 'user_email_required'.tr);
        isLoading = false;
        update();
        return false;
      }

      final fullAddress = _buildFullAddress();
      final cityTranslated = selectedCity!.tr;

      // Save to local storage - store the city KEY not the translated name
      await storage.saveLocationData(
        country: 'Bahrain',
        city: selectedCity!, // Store the key (city_manama) not translation (Manama)
        latitude: latitude!,
        longitude: longitude!,
        locationName: areaController.text.trim(),
        fullAddress: fullAddress,
      );

      final locationData = {
        'userEmail': userEmail,
        'country': 'Bahrain',
        'city': cityTranslated,
        'cityKey': selectedCity,
        'latitude': latitude,
        'longitude': longitude,
        'area': areaController.text.trim(),
        'floor': floorController.text.trim(),
        'apartment': apartmentController.text.trim(),
        'phone': phoneController.text.trim(),
        'notes': notesController.text.trim(),
        'fullAddress': fullAddress,
        'updatedAt': FieldValue.serverTimestamp(),
        'createdAt': hasExistingLocation ? null : FieldValue.serverTimestamp(),
      };

      await _firestore.collection('user_locations').doc(userEmail).set(locationData, SetOptions(merge: true));

      Get.snackbar('success'.tr, 'location_saved_successfully'.tr, snackPosition: SnackPosition.BOTTOM);

      if (kDebugMode) {
        print('✅ Location saved successfully');
        print('📍 City: $cityTranslated');
        print('📍 Coordinates: $latitude, $longitude');
        print('📍 Address: $fullAddress');
      }

      return true;
    } catch (e) {
      Get.snackbar('error'.tr, 'location_save_error'.tr, snackPosition: SnackPosition.BOTTOM);
      if (kDebugMode) {
        print('❌ Error saving location: $e');
      }
      return false;
    } finally {
      isLoading = false;
      update();
    }
  }

  String _buildFullAddress() {
    final parts = <String>[];

    if (apartmentController.text.trim().isNotEmpty) {
      parts.add('${'apartment'.tr} ${apartmentController.text.trim()}');
    }

    if (floorController.text.trim().isNotEmpty) {
      parts.add('${'floor'.tr} ${floorController.text.trim()}');
    }

    if (areaController.text.trim().isNotEmpty) {
      parts.add(areaController.text.trim());
    }

    if (selectedCity != null) {
      parts.add(selectedCity!.tr);
    }

    parts.add('Bahrain');

    return parts.join(', ');
  }

  void clearForm() {
    selectedCity = null;
    latitude = null;
    longitude = null;
    areaController.clear();
    floorController.clear();
    apartmentController.clear();
    notesController.clear();
    phoneController.clear();
    hasExistingLocation = false;
    update();
  }
}
