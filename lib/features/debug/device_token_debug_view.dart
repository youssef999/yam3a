import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/noti/recieve_noti.dart';
import 'package:shop_app/core/res/app_colors.dart';

class DeviceTokenDebugView extends StatelessWidget {
  const DeviceTokenDebugView({super.key});

  @override
  Widget build(BuildContext context) {
    final FCMNotificationReceiver receiver = Get.find<FCMNotificationReceiver>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Token Debug'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryColor),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.phone_android,
                    size: 48,
                    color: primaryColor,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'FCM Device Token',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Copy this token to test push notifications',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Token Display
            Obx(() => Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: dividerColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.key, color: Colors.orange),
                      const SizedBox(width: 8),
                      const Text(
                        'Device Token:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      if (receiver.deviceToken != null)
                        IconButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: receiver.deviceToken!));
                            Get.snackbar(
                              'Copied!',
                              'Device token copied to clipboard',
                              backgroundColor: successColor,
                              colorText: splashTextColor,
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 2),
                            );
                          },
                          icon: const Icon(Icons.copy),
                          tooltip: 'Copy Token',
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: SelectableText(
                      receiver.deviceToken ?? 'Loading token...',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            )),
            
            const SizedBox(height: 24),
            
            // Refresh Button
            ElevatedButton.icon(
              onPressed: () async {
                final newToken = await receiver.refreshToken();
                if (newToken != null) {
                  Get.snackbar(
                    'Success',
                    'Token refreshed successfully',
                    backgroundColor: successColor,
                    colorText: splashTextColor,
                  );
                } else {
                  Get.snackbar(
                    'Error',
                    'Failed to refresh token',
                    backgroundColor: failColor,
                    colorText: splashTextColor,
                  );
                }
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh Token'),
            ),
            
            const SizedBox(height: 12),
            
            // Print to Console Button
            ElevatedButton.icon(
              onPressed: () {
                final token = receiver.deviceToken;
                if (token != null) {
                  debugPrint('🔥🔥🔥 FCM DEVICE TOKEN 🔥🔥🔥');
                  debugPrint('📱 $token');
                  debugPrint('🔥🔥🔥 END TOKEN 🔥🔥🔥');
                  
                  Get.snackbar(
                    'Printed',
                    'Token printed to console (check debug logs)',
                    backgroundColor: Colors.blue[100],
                    colorText: Colors.blue[800],
                  );
                } else {
                  Get.snackbar(
                    'Error',
                    'No token available',
                    backgroundColor: failColor,
                    colorText: splashTextColor,
                  );
                }
              },
              icon: const Icon(Icons.print),
              label: const Text('Print to Console'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Instructions
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: Colors.amber[700]),
                      const SizedBox(width: 8),
                      Text(
                        'How to Use:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.amber[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('1. Copy the token above'),
                  const Text('2. Use it in your FCM testing tools'),
                  const Text('3. Or navigate to /test_notifications for full testing UI'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => Get.toNamed('/test_notifications'),
                    child: const Text('Open Test Notifications'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}