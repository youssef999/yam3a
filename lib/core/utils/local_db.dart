// lib/services/local_storage_service.dart
import 'dart:math';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/widgets.dart';

/// A simple service for local persistent storage using GetStorage.
class LocalStorageService {
  final GetStorage _box;

  LocalStorageService(this._box);

  // --------- Generic methods ---------
  Future<void> write(String key, dynamic value) async => await _box.write(key, value);
  T? read<T>(String key) => _box.read<T>(key);
  Future<void> delete(String key) async => await _box.remove(key);
  Future<void> clear() async => await _box.erase();

  // --------- Convenient shortcuts for common keys ---------
  static const _authTokenKey = 'auth_token';
  static const _email = 'user_email';
  static const _name = 'user_name';
  
  // Location storage keys
  static const _countryKey = 'user_country';
  static const _cityKey = 'user_city';
  static const _latitudeKey = 'user_latitude';
  static const _longitudeKey = 'user_longitude';
  static const _locationNameKey = 'user_location_name';
  static const _fullAddressKey = 'user_full_address';
  static const _lastLocationUpdateKey = 'last_location_update';
  
  // Category storage keys
  static const _selectedCategoryIdKey = 'selected_category_id';
  static const _selectedCategoryNameKey = 'selected_category_name';
  static const _selectedCategoryNameEnKey = 'selected_category_name_en';
  static const _selectedCategoryTypeKey = 'selected_category_type';
  static const _selectedCategoryImageKey = 'selected_category_image';

//read
  String? get authToken => read<String>(_authTokenKey);
  String? get userEmail => read<String>(_email);
  String? get userName => read<String>(_name);
  
  // Location read methods
  String? get userCountry => read<String>(_countryKey);
  String? get userCity => read<String>(_cityKey);
  double? get userLatitude => read<double>(_latitudeKey);
  double? get userLongitude => read<double>(_longitudeKey);
  String? get userLocationName => read<String>(_locationNameKey);
  String? get userFullAddress => read<String>(_fullAddressKey);
  String? get lastLocationUpdate => read<String>(_lastLocationUpdateKey);
  
  // Category read methods
  String? get selectedCategoryId => read<String>(_selectedCategoryIdKey);
  String? get selectedCategoryName => read<String>(_selectedCategoryNameKey);
  String? get selectedCategoryNameEn => read<String>(_selectedCategoryNameEnKey);
  String? get selectedCategoryType => read<String>(_selectedCategoryTypeKey);
  String? get selectedCategoryImage => read<String>(_selectedCategoryImageKey);

//write
  Future<void> saveAuthToken(String token) async => await write(_authTokenKey, token);
  Future<void> saveUserName(String name) async => await write(_name, name);
  Future<void> saveUserEmail(String email) async => await write(_email, email);
  
  // Location write methods
  Future<void> saveUserCountry(String country) async => await write(_countryKey, country);
  Future<void> saveUserCity(String city) async => await write(_cityKey, city);
  Future<void> saveUserLatitude(double latitude) async => await write(_latitudeKey, latitude);
  Future<void> saveUserLongitude(double longitude) async => await write(_longitudeKey, longitude);
  Future<void> saveUserLocationName(String locationName) async => await write(_locationNameKey, locationName);
  Future<void> saveUserFullAddress(String fullAddress) async => await write(_fullAddressKey, fullAddress);
  Future<void> saveLastLocationUpdate(String timestamp) async => await write(_lastLocationUpdateKey, timestamp);
  
  // Category write methods
  Future<void> saveSelectedCategoryId(String categoryId) async => await write(_selectedCategoryIdKey, categoryId);
  Future<void> saveSelectedCategoryName(String categoryName) async => await write(_selectedCategoryNameKey, categoryName);
  Future<void> saveSelectedCategoryNameEn(String categoryNameEn) async => await write(_selectedCategoryNameEnKey, categoryNameEn);
  Future<void> saveSelectedCategoryType(String categoryType) async => await write(_selectedCategoryTypeKey, categoryType);
  Future<void> saveSelectedCategoryImage(String categoryImage) async => await write(_selectedCategoryImageKey, categoryImage);
  
  /// Save complete location data in one call
  Future<void> saveLocationData({
    required String country,
    required String city,
    required double latitude,
    required double longitude,
    String? locationName,
    String? fullAddress,
  }) async {
    await saveUserCountry(country);
    await saveUserCity(city);
    await saveUserLatitude(latitude);
    await saveUserLongitude(longitude);
    if (locationName != null) await saveUserLocationName(locationName);
    if (fullAddress != null) await saveUserFullAddress(fullAddress);
    await saveLastLocationUpdate(DateTime.now().toIso8601String());
  }
  
  /// Save complete category data in one call
  Future<void> saveCategoryData({
    required String categoryId,
    required String categoryName,
    required String categoryNameEn,
    required String categoryType,
    String? categoryImage,
  }) async {
    await saveSelectedCategoryId(categoryId);
    await saveSelectedCategoryName(categoryName);
    await saveSelectedCategoryNameEn(categoryNameEn);
    await saveSelectedCategoryType(categoryType);
    if (categoryImage != null) await saveSelectedCategoryImage(categoryImage);
  }

//delete
  Future<void> deleteAuthToken() async => await delete(_authTokenKey);
  Future<void> deleteUserName() async => await delete(_name);
  Future<void> deleteUserEmail() async => await delete(_email);
  
  // Location delete methods
  Future<void> deleteUserCountry() async => await delete(_countryKey);
  Future<void> deleteUserCity() async => await delete(_cityKey);
  Future<void> deleteUserLatitude() async => await delete(_latitudeKey);
  Future<void> deleteUserLongitude() async => await delete(_longitudeKey);
  Future<void> deleteUserLocationName() async => await delete(_locationNameKey);
  Future<void> deleteUserFullAddress() async => await delete(_fullAddressKey);
  Future<void> deleteLastLocationUpdate() async => await delete(_lastLocationUpdateKey);
  
  // Category delete methods
  Future<void> deleteSelectedCategoryId() async => await delete(_selectedCategoryIdKey);
  Future<void> deleteSelectedCategoryName() async => await delete(_selectedCategoryNameKey);
  Future<void> deleteSelectedCategoryNameEn() async => await delete(_selectedCategoryNameEnKey);
  Future<void> deleteSelectedCategoryType() async => await delete(_selectedCategoryTypeKey);
  Future<void> deleteSelectedCategoryImage() async => await delete(_selectedCategoryImageKey);
  
  /// Delete all location data
  Future<void> deleteAllLocationData() async {
    await deleteUserCountry();
    await deleteUserCity();
    await deleteUserLatitude();
    await deleteUserLongitude();
    await deleteUserLocationName();
    await deleteUserFullAddress();
    await deleteLastLocationUpdate();
  }
  
  /// Delete all category data
  Future<void> deleteAllCategoryData() async {
    await deleteSelectedCategoryId();
    await deleteSelectedCategoryName();
    await deleteSelectedCategoryNameEn();
    await deleteSelectedCategoryType();
    await deleteSelectedCategoryImage();
  }
  
  /// Check if location data exists
  bool hasLocationData() {
    return userLatitude != null && userLongitude != null;
  }
  
  /// Check if category data exists
  bool hasCategoryData() {
    return selectedCategoryId != null && selectedCategoryType != null;
  }
  
  /// Check if user name is empty or null and needs to be fetched
  bool needsUserNameFetch() {
    final name = userName;
    return name == null || name.isEmpty || name == 'user' || name == 'المستخدم';
  }
  
  /// Check if user has complete profile data
  bool hasCompleteUserData() {
    return userName != null && userName!.isNotEmpty && 
           userEmail != null && userEmail!.isNotEmpty &&
           userName != 'user' && userName != 'المستخدم';
  }
  
  /// Delete all user data (logout functionality)
  Future<void> deleteAllUserData() async {
    await deleteAuthToken();
    await deleteUserName();
    await deleteUserEmail();
  }
  
  /// Complete logout - clears all user and app data
  Future<void> logout() async {
    await deleteAllUserData();
    await deleteAllLocationData();  
    await deleteAllCategoryData();
    // Keep language preference during logout
  }
  
  /// Get location distance between stored and new coordinates
  double? getLocationDistance(double newLat, double newLng) {
    final storedLat = userLatitude;
    final storedLng = userLongitude;
    
    if (storedLat == null || storedLng == null) return null;
    
    // Calculate distance using Haversine formula (simplified)
    const double earthRadius = 6371; // km
    final double latDiff = (newLat - storedLat) * (pi / 180);
    final double lngDiff = (newLng - storedLng) * (pi / 180);
    
    final double a = pow(sin(latDiff / 2), 2) +
        cos(storedLat * pi / 180) * cos(newLat * pi / 180) *
        pow(sin(lngDiff / 2), 2);
    
    final double c = 2 * asin(sqrt(a));
    return earthRadius * c;
  }

}

/// Global service locator
final GetIt getIt = GetIt.instance;

/// Global shortcut to access storage anywhere without boilerplate
LocalStorageService get storage => getIt<LocalStorageService>();

/// Call this once at app startup (before runApp)
Future<void> setupLocalStorage() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is ready
  await GetStorage.init();                   // Initialize GetStorage
  getIt.registerLazySingleton<LocalStorageService>(
    () => LocalStorageService(GetStorage()),
  );
}


/*
// Write
await storage.saveAuthToken('abcd1234');

// Read
final token = storage.authToken;

// Delete
await storage.deleteAuthToken();

// Clear all local data
await storage.clear();

*/
