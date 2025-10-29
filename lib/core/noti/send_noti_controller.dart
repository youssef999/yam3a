import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class FCMNotificationSender extends GetxController {
  // Firebase Project ID - Update this with your project ID
  static const String _projectId = 'ya3a-app';
  //'servicesapp2024';
  
  // FCM endpoint using HTTP v1 API
  static String get _fcmEndpoint => 
      'https://fcm.googleapis.com/v1/projects/$_projectId/messages:send';

  /// Get OAuth2 access token using service account credentials
  static Future<String> _getAccessToken() async {

    /*
      "project_info": {
    "project_number": "199212985609",
    "project_id": "ya3a-app",
    "storage_bucket": "ya3a-app.firebasestorage.app"
  },
    */
    // Service Account JSON credentials
    // Get this from Firebase Console > Project Settings > Service Accounts > Generate New Private Key
    final serviceAccountJson = {
  "type": "service_account",
  "project_id": "ya3a-app",
  "private_key_id": "9b8183b7726e5efbaf77f9e8b6230ccb9c0aa233",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDxK7uVaSGxrY/7\n/HMeXzhBsMa6JeBKxe6zENB5Usiwtyk6u3g1LEJ0IyUO4jMln41K13bgjwCpKdHG\n3IhKQWOWjdzgdlrXlAjnBIKjLqNO4TA1HZaRMUjc5FyyYRNkk0BkwjJnQRLZbyr9\np+UM4OE4Px2GtWtG0T4lS69mCU/2SxXPd+VkkEfpWLVZ9dKJS7BXJt2yhVESN6nt\nPG8uYXGsBNW6UIC09a3kaclKWFNh8wCnSIDF3Gaxspogo7AO8uo+7thmpJhRciR/\nYnBJ+a8vfD+TpoLGgJD+8Jx/bT5MpeUlPnaL7IlmJAdHHaY5LWFmiKf5PvQOlCoN\nfwgmRWdpAgMBAAECggEACQfuVbNawsapMUJUNL9T0djq7ipQLnigPkYbSmnEUGLB\neVyvDQ2v3N26i+bCS87AWZy9K75LI+qIG5pjQ6WUcz0zd9fSwcceOLlpY28yCBiE\nZ77Ihj4aWIQ4KOlb8qyVcRh5DvcHu8rvCRHeEMgEgwjRBBv7zQp1mWuuwSNI4mP9\ni4lvEu7NAH/8zkHzkRjpAkYCraSIFZxKQXgWxEF4kt6dc6JYsu9qlY493GD5P67A\n3cTczD+AD3gbRN02uBnl8hMm9r+xWUWrfUfAykQLtsPZfbUOFL/QLpkNYK70GUIO\ngs9RkJp5Wpjy69wehLdzjurRvsqIKM0S3cClIz1RcQKBgQD9hCDRwLi61x4j3Ohe\nsGgl9HMZ17POjunMF9mzgnKTuLg8ADWcIMzrJlbhkh5e7qnScZZ5V+yOBqKpCIZN\nezZc7BM8Mhw3hE9fCAj+gxLbkYiSWcLs2Yq5w9Kcc8boXYsMCB1ZmkuG4TQe17c0\naC98A4hbH7XMeXWhfRIpUkOvGQKBgQDziKPTzPRwmedLMbyqnr/Gm5qDVWDxtcQl\njG8iiqUl0DrfaK7NPDKDFnI0cXQVbGNLBjIRU+fO3anOcFpzy5JMyDbQ2uXBVa5e\nW1rYaDbt0dDBwc45K/AfqQo1iLoc53ydVGGoUNMZHzZYGOtkhTlGN43WamLdCpeB\n5KUOGDGU0QKBgDpcY23GDwC8Ku0YmsnJlIBAUQr+9B62Ga5pQy2m9xd4q7jsV2sU\nxffQQKn3CFTUXnXavkg67HMZpfKByuElXzNvCVKPOp2xMNBwuhlVNU8kpqsCTPRX\ndC8lnGN157Fwb2UarR8GfSKUz3nWMQ+4eE31RjusBh8HSwQdFcQ7cudpAoGBAKLL\nB0CQ9CHFL5DbWZPwdJ/t6la6nwhUih7ThoLfjU/+pywqjRcSk21/dq5J3OBpSOKg\n7J0aqo1lLZqbDkvznAOJnuL0QLuBbAMVLGAXIgjNxa+PvywGjAiN9g4dLNQfhfSh\nsHpUNRjI/YncdpYGXGfswPrAuP+rkeW5kwAd+h7RAoGAR4fxV9dlL0eO5MgKiqXX\nLXy5f0TXh5U82cH8FfoTIVbUI0c+tCm5rsWxVi5tMoaOgXdsQtZGImip3XE1D3IC\n9ZotVuJEz6Fi27y7vyPbPQuW9GVyVkDRtzUSk4iptrHBHi0vYNmsqeqxnrn3CaZt\nOPdxOMEskd4QM3Vcnz/SV+g=\n-----END PRIVATE KEY-----\n",
  "client_email": "firebase-adminsdk-fbsvc@ya3a-app.iam.gserviceaccount.com",
  "client_id": "109875574524975668320",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40ya3a-app.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
    };

    // Required OAuth2 scopes for FCM
    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    try {
      // Create HTTP client with service account credentials
      http.Client client = await auth.clientViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
        scopes,
      );

      // Obtain access credentials
      auth.AccessCredentials credentials =
          await auth.obtainAccessCredentialsViaServiceAccount(
              auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
              scopes,
              client);

      client.close();
      
      debugPrint('✅ OAuth2 access token obtained successfully');
      return credentials.accessToken.data;
    } catch (e) {
      debugPrint('💥 Error getting access token: $e');
      rethrow;
    }
  }

  /// Send FCM notification to a specific device using HTTP v1 API
  /// 
  /// [deviceToken] - FCM token of the target device
  /// [title] - Notification title
  /// [body] - Notification body content
  /// [data] - Optional custom data payload
  Future<bool> sendNotificationToDevice({
    required String deviceToken,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    try {
      if (deviceToken.isEmpty) {
        debugPrint('❌ Device token is empty');
        return false;
      }

      if (title.isEmpty || body.isEmpty) {
        debugPrint('❌ Title or body is empty');
        return false;
      }

      // Get OAuth2 access token
      final String accessToken = await _getAccessToken();

      // Build FCM v1 message payload
      final Map<String, dynamic> message = {
        "message": {
          "token": deviceToken,
          "notification": {
            "title": title,
            "body": body,
          },
          "data": data ?? {},
          "android": {
            "priority": "high",
            "notification": {
              "channel_id": "yamaa_notifications",
              "sound": "default",
              "notification_priority": "PRIORITY_MAX",
              "visibility": "public",
              "default_sound": true,
              "default_vibrate_timings": true,
            }
          },
          "apns": {
            "headers": {
              "apns-priority": "10",
            },
            "payload": {
              "aps": {
                "alert": {
                  "title": title,
                  "body": body,
                },
                "sound": "default",
                "badge": 1,
                "content-available": 1,
              }
            }
          }
        }
      };

      debugPrint('📤 Sending FCM notification (HTTP v1 API)...');
      debugPrint('📱 To device: ${deviceToken.substring(0, 20)}...');
      debugPrint('📝 Title: $title');
      debugPrint('📄 Body: $body');

      // Send HTTP request
      final response = await http.post(
        Uri.parse(_fcmEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(message),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        debugPrint('✅ Notification sent successfully');
        debugPrint('📊 Response: $responseData');
        
        // Show success feedback
        Get.snackbar(
          'success'.tr,
          'notification_sent_successfully'.tr,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green[100],
          colorText: Colors.green[800],
          icon: Icon(Icons.check_circle, color: Colors.green[800]),
          duration: const Duration(seconds: 3),
        );
        
        return true;
      } else {
        debugPrint('❌ Failed to send notification');
        debugPrint('📊 Status: ${response.statusCode}');
        debugPrint('📊 Response: ${response.body}');
        
        // Show error feedback
        Get.snackbar(
          'error'.tr,
          'failed_to_send_notification'.tr,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[100],
          colorText: Colors.red[800],
          icon: Icon(Icons.error_outline, color: Colors.red[800]),
          duration: const Duration(seconds: 3),
        );
        
        return false;
      }
    } catch (e, stackTrace) {
      debugPrint('💥 Error sending FCM notification: $e');
      debugPrint('📚 Stack trace: $stackTrace');
      
      // Show error feedback
      Get.snackbar(
        'error'.tr,
        'notification_send_error'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
        icon: Icon(Icons.error_outline, color: Colors.red[800]),
        duration: const Duration(seconds: 3),
      );
      
      return false;
    }
  }

  /// Send notification to multiple devices
  /// Note: HTTP v1 API doesn't support batch sending to multiple tokens in one request
  /// This method sends individual notifications to each device
  /// 
  /// [deviceTokens] - List of FCM tokens
  /// [title] - Notification title
  /// [body] - Notification body content
  /// [data] - Optional custom data payload
  Future<int> sendNotificationToMultipleDevices({
    required List<String> deviceTokens,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    try {
      if (deviceTokens.isEmpty) {
        debugPrint('❌ Device tokens list is empty');
        return 0;
      }

      debugPrint('📤 Sending FCM notification to ${deviceTokens.length} devices...');
      debugPrint('📝 Title: $title');
      debugPrint('📄 Body: $body');

      int successCount = 0;
      int failureCount = 0;

      // Send notification to each device individually
      for (String token in deviceTokens) {
        bool sent = await sendNotificationToDevice(
          deviceToken: token,
          title: title,
          body: body,
          data: data,
        );
        
        if (sent) {
          successCount++;
        } else {
          failureCount++;
        }
      }
      
      debugPrint('✅ Notification sent to $successCount devices');
      debugPrint('❌ Failed to send to $failureCount devices');
      
      // Show success feedback
      Get.snackbar(
        'success'.tr,
        'notification_sent_to_devices'.trParams({
          'success': successCount.toString(),
          'total': deviceTokens.length.toString(),
        }),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green[100],
        colorText: Colors.green[800],
        icon: Icon(Icons.check_circle, color: Colors.green[800]),
        duration: const Duration(seconds: 3),
      );
      
      return successCount;
    } catch (e, stackTrace) {
      debugPrint('💥 Error sending FCM notification: $e');
      debugPrint('📚 Stack trace: $stackTrace');
      return 0;
    }
  }

  /// Send chat message notification
  /// Specialized for chat notifications with specific data
  Future<bool> sendChatNotification({
    required String deviceToken,
    required String senderName,
    required String message,
    required String chatId,
    required String brandName,
  }) async {
    final title = 'new_message_from'.trParams({'name': senderName});
    final body = message.length > 100 ? '${message.substring(0, 100)}...' : message;
    
    final data = {
      'type': 'chat_message',
      'chat_id': chatId,
      'sender_name': senderName,
      'brand_name': brandName,
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'route': '/chat',
    };

    return await sendNotificationToDevice(
      deviceToken: deviceToken,
      title: title,
      body: body,
      data: data,
    );
  }

  /// Send order notification
  /// Specialized for order updates
  Future<bool> sendOrderNotification({
    required String deviceToken,
    required String orderStatus,
    required String orderId,
    String? brandName,
  }) async {
    final title = 'order_status_update'.tr;
    final body = 'order_status_changed'.trParams({
      'orderId': orderId,
      'status': orderStatus,
    });
    
    final data = {
      'type': 'order_update',
      'order_id': orderId,
      'status': orderStatus,
      'brand_name': brandName ?? '',
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'route': '/orders',
    };

    return await sendNotificationToDevice(
      deviceToken: deviceToken,
      title: title,
      body: body,
      data: data,
    );
  }

  /// Send brand notification
  /// For brand-related updates
  Future<bool> sendBrandNotification({
    required String deviceToken,
    required String brandName,
    required String notificationMessage,
    String? brandId,
  }) async {
    final title = brandName;
    final body = notificationMessage;
    
    final data = {
      'type': 'brand_notification',
      'brand_id': brandId ?? '',
      'brand_name': brandName,
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'route': '/brands',
    };

    return await sendNotificationToDevice(
      deviceToken: deviceToken,
      title: title,
      body: body,
      data: data,
    );
  }

  /// Test notification sender
  /// For development and testing purposes
  Future<bool> sendTestNotification({
    required String deviceToken,
    required String title,
    required String body,
  }) async {
    return await sendNotificationToDevice(
      deviceToken: deviceToken,
      title: title,
      body: body,
      data: {
        'type': 'test',
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }
}