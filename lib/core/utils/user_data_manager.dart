import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/core/utils/local_db.dart';

/// Utility class for managing user data across the app
class UserDataManager {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  /// Check and fetch user name if it's missing or invalid
  static Future<void> ensureUserNameIsAvailable() async {
    if (storage.needsUserNameFetch()) {
      await _fetchUserNameFromFirebase();
    }
  }
  
  /// Fetch user name from Firebase and save to local storage
  static Future<void> _fetchUserNameFromFirebase() async {
    try {
      final email = storage.userEmail;
      if (email == null || email.isEmpty) {
        print('No email found in local storage, cannot fetch user name');
        return;
      }
      
      print('Fetching user name from Firebase for email: $email');
      
      final doc = await _firestore.collection('users').doc(email).get();
      if (doc.exists) {
        final data = doc.data();
        final firebaseName = data?['name'] ?? data?['userName'] ?? data?['displayName'] ?? '';
        
        if (firebaseName.isNotEmpty) {
          // Save the fetched name to local storage
          await storage.saveUserName(firebaseName);
          print('User name fetched and saved: $firebaseName');
        } else {
          print('No valid name found in Firebase document');
          // Set a default name based on email
          final emailName = email.split('@')[0];
          await storage.saveUserName(emailName);
          print('Set default name from email: $emailName');
        }
      } else {
        print('User document does not exist in Firebase');
        // Create a basic user document
        await _createBasicUserDocument(email);
      }
    } catch (e) {
      print('Error fetching user name from Firebase: $e');
      // If Firebase fails, set a basic default name
      await _setFallbackUserName();
    }
  }
  
  /// Create a basic user document in Firebase if it doesn't exist
  static Future<void> _createBasicUserDocument(String email) async {
    try {
      final emailName = email.split('@')[0];
      await _firestore.collection('users').doc(email).set({
        'email': email,
        'name': emailName,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      
      await storage.saveUserName(emailName);
      print('Created basic user document and saved name: $emailName');
    } catch (e) {
      print('Error creating basic user document: $e');
      await _setFallbackUserName();
    }
  }
  
  /// Set a fallback user name when all else fails
  static Future<void> _setFallbackUserName() async {
    try {
      final email = storage.userEmail;
      if (email != null && email.isNotEmpty) {
        final fallbackName = email.split('@')[0];
        await storage.saveUserName(fallbackName);
        print('Set fallback name: $fallbackName');
      } else {
        await storage.saveUserName('User');
        print('Set default fallback name: User');
      }
    } catch (e) {
      print('Error setting fallback name: $e');
    }
  }
  
  /// Get current user name, fetch from Firebase if needed
  static Future<String> getUserName() async {
    if (storage.needsUserNameFetch()) {
      await ensureUserNameIsAvailable();
    }
    return storage.userName ?? 'User';
  }
  
  /// Refresh user data from Firebase
  static Future<void> refreshUserData() async {
    await _fetchUserNameFromFirebase();
  }
  
  /// Check if user data is complete and valid
  static bool isUserDataComplete() {
    return storage.hasCompleteUserData();
  }
  
  /// Logout user and clear all data
  static Future<void> logoutUser() async {
    try {
      await storage.logout();
      print('User logged out successfully, all data cleared');
    } catch (e) {
      print('Error during logout: $e');
      throw e;
    }
  }
}