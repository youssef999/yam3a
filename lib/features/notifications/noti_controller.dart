import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/utils/local_db.dart';

class NotificationController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  final List<Map<String, dynamic>> notifications = [];
  bool isLoading = false;
  bool isMarkingAllRead = false;
  String? errorMessage;

  @override
  void onInit() {
    super.onInit();
 //   addTestNotification();
    fetchNotifications();
  }

  /// Add test notification data to Firestore
  Future<void> addTestNotification() async {
    try {
      isLoading = true;
      update();

      // Get current user email
      String userEmail = storage.userEmail ?? 'test@gmail.com';
      
      // Create test notification data
      final testNotification = {
        'email': userEmail,
        'title': 'Test Notification ${DateTime.now().millisecondsSinceEpoch}',
        'message': 'This is a test notification message sent at ${DateTime.now().toString()}',
        'dateTime': DateTime.now(),
        'isRead': false,
        'type': 'test',
        'createdAt': FieldValue.serverTimestamp(),
      };

      // Add to Firestore
      final docRef = await _firestore
          .collection('noti')
          .add(testNotification);

      if (kDebugMode) {
        print('✅ Test notification added successfully!');
        print('📄 Document ID: ${docRef.id}');
        print('📧 Email: test@gmail.com');
        print('📝 Title: ${testNotification['title']}');
        print('💬 Message: ${testNotification['message']}');
        print('🕒 DateTime: ${testNotification['dateTime']}');
      }

      // Show success message
      Get.snackbar(
        'success'.tr,
        'test_notification_added'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[100],
        colorText: Colors.green[800],
        icon: const Icon(Icons.check_circle, color: Colors.green),
        duration: const Duration(seconds: 3),
      );

      // Refresh notifications list
      await fetchNotifications();

    } catch (e, stackTrace) {
      debugPrint('💥 Error adding test notification: $e');
      debugPrint(stackTrace.toString());
      
      errorMessage = e.toString();
      Get.snackbar(
        'error'.tr,
        'failed_to_add_notification'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
        icon: const Icon(Icons.error_outline, color: Colors.red),
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  /// Add multiple test notifications
  Future<void> addMultipleTestNotifications(int count) async {
    try {
      isLoading = true;
      update();

      // Get current user email
      String userEmail = storage.userEmail ?? 'test@gmail.com';
      
      final batch = _firestore.batch();
      final now = DateTime.now();

      for (int i = 0; i < count; i++) {
        final docRef = _firestore.collection('noti').doc();
        final testNotification = {
          'email': userEmail,
          'title': 'Test Notification #${i + 1}',
          'message': 'This is test notification number ${i + 1} created at ${now.add(Duration(minutes: i)).toString()}',
          'dateTime': now.add(Duration(minutes: i)),
          'isRead': i % 2 == 0, // Alternate read/unread status
          'type': i % 3 == 0 ? 'order' : i % 3 == 1 ? 'promotion' : 'general',
          'createdAt': FieldValue.serverTimestamp(),
        };
        
        batch.set(docRef, testNotification);
      }

      await batch.commit();

      if (kDebugMode) {
        print('✅ $count test notifications added successfully!');
      }

      Get.snackbar(
        'success'.tr,
        '$count test notifications added successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[100],
        colorText: Colors.green[800],
        icon: const Icon(Icons.check_circle, color: Colors.green),
        duration: const Duration(seconds: 3),
      );

      await fetchNotifications();

    } catch (e, stackTrace) {
      debugPrint('💥 Error adding multiple test notifications: $e');
      debugPrint(stackTrace.toString());
      
      errorMessage = e.toString();
      Get.snackbar(
        'error'.tr,
        'failed_to_add_notifications'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
        icon: const Icon(Icons.error_outline, color: Colors.red),
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  /// Fetch notifications from Firestore for current user
  Future<void> fetchNotifications() async {
    try {
      isLoading = true;
      update();

      // Get current user email from local storage
      String userEmail = storage.userEmail ?? 'test@gmail.com';
      
      final snapshot = await _firestore
          .collection('noti')
          .where('email', isEqualTo: userEmail)
          .orderBy('dateTime', descending: true)
          .limit(50)
          .get();

      notifications.clear();
      notifications.addAll(
        snapshot.docs.map((doc) => {
          'id': doc.id,
          ...doc.data(),
        }).toList(),
      );

      if (kDebugMode) {
        print('📋 Fetched ${notifications.length} notifications for user: $userEmail');
      }

      errorMessage = null;
    } catch (e, stackTrace) {
      debugPrint('💥 Error fetching notifications: $e');
      debugPrint(stackTrace.toString());
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      update();
    }
  }

  /// Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    try {
      await _firestore
          .collection('noti')
          .doc(notificationId)
          .update({'isRead': true});

      // Update local list
      final index = notifications.indexWhere((n) => n['id'] == notificationId);
      if (index != -1) {
        notifications[index]['isRead'] = true;
        update();
      }

      if (kDebugMode) {
        print('✅ Notification $notificationId marked as read');
      }
    } catch (e) {
      debugPrint('💥 Error marking notification as read: $e');
    }
  }

  /// Mark all unread notifications as read for current user
  Future<void> markAllAsRead() async {

    Future.delayed(const Duration(seconds: 5)).then((_) async {

  
    try {
      isMarkingAllRead = true;
      update();

      // Get current user email from local storage
      String userEmail = storage.userEmail ?? 'test@gmail.com';
      
      final snapshot = await _firestore
          .collection('noti')
          .where('email', isEqualTo: userEmail)
          .where('isRead', isEqualTo: false)
          .get();

      if (snapshot.docs.isEmpty) {
        if (kDebugMode) {
          print('📋 No unread notifications to mark as read');
        }
        return;
      }

      final batch = _firestore.batch();
      for (var doc in snapshot.docs) {
        batch.update(doc.reference, {'isRead': true});
      }
      
      await batch.commit();

      // Update local list
      for (var notification in notifications) {
        if (notification['isRead'] == false) {
          notification['isRead'] = true;
        }
      }

      if (kDebugMode) {
        print('✅ Marked ${snapshot.docs.length} notifications as read');
      }

      if (snapshot.docs.isNotEmpty) {
        // ignore: avoid_print
        print('✅ Marked all notifications as read');
        // Get.snackbar(
        //   'success'.tr,
        //   'all_notifications_read'.tr,
        //   snackPosition: SnackPosition.BOTTOM,
        //   backgroundColor: Colors.green[100],
        //   colorText: Colors.green[800],
        //   icon: const Icon(Icons.check_circle, color: Colors.green),
        //   duration: const Duration(seconds: 2),
        // );
      }
    } catch (e) {
      debugPrint('💥 Error marking all notifications as read: $e');
    } finally {
      isMarkingAllRead = false;
      update();
    }
      });
  }

  /// Delete notification
  Future<void> deleteNotification(String notificationId) async {
    try {
      await _firestore
          .collection('noti')
          .doc(notificationId)
          .delete();

      // Remove from local list
      notifications.removeWhere((n) => n['id'] == notificationId);
      update();

      if (kDebugMode) {
        print('🗑️ Notification $notificationId deleted');
      }

      Get.snackbar(
        'success'.tr,
        'notification_deleted'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[100],
        colorText: Colors.green[800],
        icon: const Icon(Icons.check_circle, color: Colors.green),
      );
    } catch (e) {
      debugPrint('💥 Error deleting notification: $e');
      Get.snackbar(
        'error'.tr,
        'failed_to_delete_notification'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
        icon: const Icon(Icons.error_outline, color: Colors.red),
      );
    }
  }

  /// Clear all notifications for current user
  Future<void> clearAllNotifications() async {
    try {
      isLoading = true;
      update();

      // Get current user email from local storage
      String userEmail = storage.userEmail ?? 'test@gmail.com';
      
      final snapshot = await _firestore
          .collection('noti')
          .where('email', isEqualTo: userEmail)
          .get();

      final batch = _firestore.batch();
      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      
      await batch.commit();
      
      notifications.clear();
      update();

      if (kDebugMode) {
        print('🗑️ All notifications cleared for $userEmail');
      }

      Get.snackbar(
        'success'.tr,
        'all_notifications_cleared'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[100],
        colorText: Colors.green[800],
        icon: const Icon(Icons.check_circle, color: Colors.green),
      );
    } catch (e) {
      debugPrint('💥 Error clearing notifications: $e');
      Get.snackbar(
        'error'.tr,
        'failed_to_clear_notifications'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
        icon: const Icon(Icons.error_outline, color: Colors.red),
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  /// Get unread notifications count for current user
  int get unreadCount => notifications.where((n) => n['isRead'] == false).length;

  /// Get unread notifications count from Firestore without loading all notifications
  static Future<int> getUnreadNotificationsCount() async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      String userEmail = storage.userEmail ?? 'test@gmail.com';
      
      final snapshot = await firestore
          .collection('noti')
          .where('email', isEqualTo: userEmail)
          .where('isRead', isEqualTo: false)
          .get();

      return snapshot.docs.length;
    } catch (e) {
      debugPrint('Error getting unread notifications count: $e');
      return 0;
    }
  }

  /// Get formatted date time
  String getFormattedDateTime(dynamic dateTime) {
    try {
      DateTime dt;
      if (dateTime is Timestamp) {
        dt = dateTime.toDate();
      } else if (dateTime is DateTime) {
        dt = dateTime;
      } else {
        return 'notification_unknown_date'.tr;
      }

      final now = DateTime.now();
      final difference = now.difference(dt);

      if (difference.inDays > 0) {
        return '${difference.inDays} ${'notification_days_ago'.tr}';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} ${'notification_hours_ago'.tr}';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} ${'notification_minutes_ago'.tr}';
      } else {
        return 'notification_just_now'.tr;
      }
    } catch (e) {
      return 'notification_unknown_date'.tr;
    }
  }
}
