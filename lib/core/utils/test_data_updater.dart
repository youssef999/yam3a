import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class TestDataUpdater {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Test function to add image field to all documents in services collection
  /// This function should only be used for testing/migration purposes
  static Future<void> testDataAddImageField() async {
    try {
      if (kDebugMode) {
        print('Starting testDataAddImageField migration...');
      }

      // Get reference to services collection
      final servicesCollection = _firestore.collection('services');
      
      // Get all documents in the collection
      final querySnapshot = await servicesCollection.get();
      
      if (kDebugMode) {
        print('Found ${querySnapshot.docs.length} documents to update');
      }

      // Batch write for better performance
      final batch = _firestore.batch();
      
      int updateCount = 0;
      
      for (final doc in querySnapshot.docs) {
        final data = doc.data();
        
        // Check if image field already exists
        if (!data.containsKey('image')) {
          // Add default image field
          batch.update(doc.reference, {
            'image': '', // Default empty string, you can set a default image URL
          });
          updateCount++;
          
          if (kDebugMode) {
            print('Updating document: ${doc.id}');
          }
        } else {
          if (kDebugMode) {
            print('Document ${doc.id} already has image field');
          }
        }
      }
      
      // Commit the batch
      if (updateCount > 0) {
        await batch.commit();
        if (kDebugMode) {
          print('Successfully updated $updateCount documents');
        }
      } else {
        if (kDebugMode) {
          print('No documents needed updating');
        }
      }
      
      if (kDebugMode) {
        print('testDataAddImageField migration completed successfully');
      }
      
    } catch (e) {
      if (kDebugMode) {
        print('Error in testDataAddImageField: $e');
      }
      rethrow;
    }
  }

  /// Alternative function to add image field with specific default image URLs
  /// You can customize this to set different default images based on service category
  static Future<void> testDataAddImageFieldWithDefaults() async {
    try {
      if (kDebugMode) {
        print('Starting testDataAddImageFieldWithDefaults migration...');
      }

      // Get reference to services collection
      final servicesCollection = _firestore.collection('services');
      
      // Get all documents in the collection
      final querySnapshot = await servicesCollection.get();
      
      if (kDebugMode) {
        print('Found ${querySnapshot.docs.length} documents to update');
      }

      // Batch write for better performance
      final batch = _firestore.batch();
      
      int updateCount = 0;
      
      for (final doc in querySnapshot.docs) {
        final data = doc.data();
        
        // Check if image field already exists
        if (!data.containsKey('image')) {
          // Get category to set appropriate default image
          final category = data['cat'] as String? ?? '';
          String defaultImage = _getDefaultImageForCategory(category);
          
          // Add image field with default value
          batch.update(doc.reference, {
            'image': defaultImage,
          });
          updateCount++;
          
          if (kDebugMode) {
            print('Updating document: ${doc.id} with category: $category');
          }
        } else {
          if (kDebugMode) {
            print('Document ${doc.id} already has image field');
          }
        }
      }
      
      // Commit the batch
      if (updateCount > 0) {
        await batch.commit();
        if (kDebugMode) {
          print('Successfully updated $updateCount documents');
        }
      } else {
        if (kDebugMode) {
          print('No documents needed updating');
        }
      }
      
      if (kDebugMode) {
        print('testDataAddImageFieldWithDefaults migration completed successfully');
      }
      
    } catch (e) {
      if (kDebugMode) {
        print('Error in testDataAddImageFieldWithDefaults: $e');
      }
      rethrow;
    }
  }

  /// Helper function to get default image URL based on category
  static String _getDefaultImageForCategory(String category) {
    // You can customize these default images based on your categories
    switch (category.toLowerCase()) {
      case 'cleaning':
      case 'تنظيف':
        return 'https://example.com/default-cleaning-service.jpg';
      case 'repair':
      case 'إصلاح':
        return 'https://example.com/default-repair-service.jpg';
      case 'maintenance':
      case 'صيانة':
        return 'https://example.com/default-maintenance-service.jpg';
      case 'installation':
      case 'تركيب':
        return 'https://example.com/default-installation-service.jpg';
      default:
        return 'https://example.com/default-service.jpg';
    }
  }

  /// Function to verify the migration was successful
  static Future<void> verifyImageFieldMigration() async {
    try {
      if (kDebugMode) {
        print('Starting verification of image field migration...');
      }

      final servicesCollection = _firestore.collection('services');
      final querySnapshot = await servicesCollection.get();
      
      int totalDocs = querySnapshot.docs.length;
      int docsWithImage = 0;
      int docsWithoutImage = 0;
      
      for (final doc in querySnapshot.docs) {
        final data = doc.data();
        if (data.containsKey('image')) {
          docsWithImage++;
        } else {
          docsWithoutImage++;
          if (kDebugMode) {
            print('Document ${doc.id} missing image field');
          }
        }
      }
      
      if (kDebugMode) {
        print('Verification Results:');
        print('Total documents: $totalDocs');
        print('Documents with image field: $docsWithImage');
        print('Documents without image field: $docsWithoutImage');
        
        if (docsWithoutImage == 0) {
          print('✅ Migration verification PASSED - All documents have image field');
        } else {
          print('❌ Migration verification FAILED - Some documents missing image field');
        }
      }
      
    } catch (e) {
      if (kDebugMode) {
        print('Error in verifyImageFieldMigration: $e');
      }
      rethrow;
    }
  }
}