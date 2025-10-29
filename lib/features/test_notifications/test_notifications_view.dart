import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/noti/send_noti_controller.dart';
import 'package:shop_app/core/noti/recieve_noti.dart';
import 'package:shop_app/core/res/app_colors.dart';

class TestNotificationsView extends StatefulWidget {
  const TestNotificationsView({super.key});

  @override
  State<TestNotificationsView> createState() => _TestNotificationsViewState();
}

class _TestNotificationsViewState extends State<TestNotificationsView> {
  final TextEditingController _customTitleController = TextEditingController(text: 'Test Notification');
  final TextEditingController _customBodyController = TextEditingController(text: 'This is a test message!');
  bool _isSending = false;

  @override
  void dispose() {
    _customTitleController.dispose();
    _customBodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FCMNotificationReceiver receiver = Get.find<FCMNotificationReceiver>();
    final FCMNotificationSender sendController = Get.put(FCMNotificationSender());

    return Scaffold(
      appBar: AppBar(
        title: const Text('🧪 FCM Testing & Debugging'),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                children: [
                  Icon(Icons.notifications_active, size: 48, color: Colors.white),
                  SizedBox(height: 8),
                  Text(
                    'FCM Notification Testing',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Test and debug your FCM notifications',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),

            // Device Token Section with enhanced debugging
            _buildSection(
              title: '📱 Device Token',
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: primaryColor.withOpacity(0.3), width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.token, color: primaryColor, size: 24),
                            const SizedBox(width: 8),
                            const Text(
                              'FCM Token:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: SelectableText(
                            receiver.deviceToken ?? '⚠️ No token available - initializing...',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'monospace',
                              color: receiver.deviceToken != null ? Colors.black87 : Colors.orange[800],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: receiver.deviceToken != null
                                    ? () {
                                        Clipboard.setData(ClipboardData(text: receiver.deviceToken!));
                                        Get.snackbar(
                                          '✅ Copied!',
                                          'Device token copied to clipboard',
                                          backgroundColor: successColor,
                                          colorText: Colors.white,
                                          snackPosition: SnackPosition.TOP,
                                          duration: const Duration(seconds: 2),
                                          icon: const Icon(Icons.check_circle, color: Colors.white),
                                        );
                                        debugPrint('📋 Token copied: ${receiver.deviceToken}');
                                      }
                                    : null,
                                icon: const Icon(Icons.copy),
                                label: const Text('Copy Token'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  debugPrint('🔄 Refreshing FCM token...');
                                  final newToken = await receiver.refreshToken();
                                  if (newToken != null) {
                                    setState(() {});
                                    Get.snackbar(
                                      '✅ Success',
                                      'Token refreshed successfully',
                                      backgroundColor: successColor,
                                      colorText: Colors.white,
                                      snackPosition: SnackPosition.TOP,
                                      duration: const Duration(seconds: 2),
                                    );
                                    debugPrint('📱 New token: $newToken');
                                  }
                                },
                                icon: const Icon(Icons.refresh),
                                label: const Text('Refresh'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),

            // Custom Notification Testing
            _buildSection(
              title: '✏️ Custom Notification Test',
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Customize your test notification:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _customTitleController,
                      decoration: InputDecoration(
                        labelText: 'Notification Title',
                        prefixIcon: Icon(Icons.title, color: primaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _customBodyController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Notification Body',
                        prefixIcon: Icon(Icons.message, color: primaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _isSending
                            ? null
                            : () => _sendCustomNotification(sendController, receiver),
                        icon: _isSending
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                              )
                            : const Icon(Icons.send),
                        label: Text(_isSending ? 'Sending...' : 'Send Custom Notification'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Quick Test Notifications Section
            _buildSection(
              title: '🚀 Quick Test Notifications',
              child: Column(
                children: [
                  _buildTestButton(
                    title: 'Test Simple Notification',
                    subtitle: 'Basic notification with sound',
                    icon: Icons.notifications,
                    color: Colors.purple,
                    onPressed: () => _sendTestNotification(sendController, receiver),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  _buildTestButton(
                    title: 'Test Chat Notification',
                    subtitle: 'Chat notification with navigation',
                    icon: Icons.chat,
                    color: Colors.green,
                    onPressed: () => _sendChatNotification(sendController, receiver),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  _buildTestButton(
                    title: 'Test Order Notification',
                    subtitle: 'Order update notification',
                    icon: Icons.shopping_bag,
                    color: Colors.orange,
                    onPressed: () => _sendOrderNotification(sendController, receiver),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  _buildTestButton(
                    title: 'Test Brand Notification',
                    subtitle: 'Brand notification',
                    icon: Icons.store,
                    color: Colors.teal,
                    onPressed: () => _sendBrandNotification(sendController, receiver),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Sound & Management Section
            _buildSection(
              title: '🔊 Sound & Management',
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            debugPrint('🔊 Testing notification sound...');
                            receiver.testNotificationSound();
                          },
                          icon: const Icon(Icons.volume_up),
                          label: const Text('Test Sound'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            debugPrint('🧹 Clearing all notifications...');
                            receiver.clearAllNotifications();
                            Get.snackbar(
                              '✅ Cleared',
                              'All notifications have been cleared',
                              backgroundColor: successColor,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.TOP,
                            );
                          },
                          icon: const Icon(Icons.clear_all),
                          label: const Text('Clear All'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: failColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Debug Info Section
            _buildSection(
              title: '🐛 Debug Information',
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[400]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDebugRow('Token Status:', receiver.deviceToken != null ? '✅ Available' : '❌ Not Available'),
                    _buildDebugRow('Project ID:', 'ya3a-app'),
                    _buildDebugRow('Channel ID:', 'yamaa_notifications'),
                    _buildDebugRow('API Version:', 'HTTP v1 (OAuth2)'),
                    const SizedBox(height: 12),
                    const Text(
                      '💡 All test notifications will appear in debug console',
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Instructions Section
            _buildSection(
              title: '📖 Testing Instructions',
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue[50]!, Colors.purple[50]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.blue[700]),
                        const SizedBox(width: 8),
                        const Text(
                          'How to Test:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildInstructionStep('1', 'Copy your device token using the button above'),
                    _buildInstructionStep('2', 'Use quick test buttons or create custom notification'),
                    _buildInstructionStep('3', 'Check debug console for detailed logs'),
                    _buildInstructionStep('4', 'Put app in background to test background mode'),
                    _buildInstructionStep('5', 'Tap notifications to test navigation'),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.orange[300]!),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.warning_amber_rounded, color: Colors.orange[800], size: 20),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              'Make sure notification permissions are granted and service account credentials are configured in send_noti_controller.dart',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }

  Widget _buildTestButton({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onPressed,
    Color? color,
  }) {
    final buttonColor = color ?? primaryColor;
    return Container(
      decoration: BoxDecoration(
        color: buttonColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: buttonColor.withOpacity(0.3), width: 2),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: buttonColor,
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 13),
        ),
        trailing: Icon(Icons.send, color: buttonColor),
        onTap: onPressed,
      ),
    );
  }

  Widget _buildDebugRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionStep(String number, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                text,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendCustomNotification(FCMNotificationSender sendController, FCMNotificationReceiver receiver) async {
    if (receiver.deviceToken == null) {
      Get.snackbar(
        '❌ Error',
        'Device token not available. Please wait for initialization.',
        backgroundColor: failColor,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      debugPrint('❌ Cannot send notification: Device token is null');
      return;
    }

    if (_customTitleController.text.isEmpty || _customBodyController.text.isEmpty) {
      Get.snackbar(
        '❌ Error',
        'Please enter both title and body',
        backgroundColor: failColor,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    setState(() => _isSending = true);
    debugPrint('📤 Sending custom notification...');
    debugPrint('📝 Title: ${_customTitleController.text}');
    debugPrint('📄 Body: ${_customBodyController.text}');
    debugPrint('📱 To token: ${receiver.deviceToken}');

    await sendController.sendTestNotification(
      deviceToken: receiver.deviceToken!,
      title: _customTitleController.text,
      body: _customBodyController.text,
    );
    
    setState(() => _isSending = false);
  }

  void _sendTestNotification(FCMNotificationSender sendController, FCMNotificationReceiver receiver) async {
    if (receiver.deviceToken == null) {
      Get.snackbar(
        '❌ Error',
        'Device token not available',
        backgroundColor: failColor,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      debugPrint('❌ Cannot send notification: Device token is null');
      return;
    }

    debugPrint('📤 Sending test notification...');
    debugPrint('📱 To token: ${receiver.deviceToken}');

    await sendController.sendTestNotification(
      deviceToken: receiver.deviceToken!,
      title: '🔔 Test Notification',
      body: 'This is a test notification from Yamaa app! You should hear a sound.',
    );
  }

  void _sendChatNotification(FCMNotificationSender sendController, FCMNotificationReceiver receiver) async {
    if (receiver.deviceToken == null) {
      Get.snackbar(
        '❌ Error',
        'Device token not available',
        backgroundColor: failColor,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      debugPrint('❌ Cannot send notification: Device token is null');
      return;
    }

    debugPrint('📤 Sending chat notification...');
    debugPrint('💬 From: Test Brand');
    debugPrint('📱 To token: ${receiver.deviceToken}');

    await sendController.sendChatNotification(
      deviceToken: receiver.deviceToken!,
      senderName: 'Test Brand',
      message: 'Hello! You have a new message from our store 💬',
      chatId: 'test_chat_123',
      brandName: 'Test Brand Store',
    );
  }

  void _sendOrderNotification(FCMNotificationSender sendController, FCMNotificationReceiver receiver) async {
    if (receiver.deviceToken == null) {
      Get.snackbar(
        '❌ Error',
        'Device token not available',
        backgroundColor: failColor,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      debugPrint('❌ Cannot send notification: Device token is null');
      return;
    }

    debugPrint('📤 Sending order notification...');
    debugPrint('📦 Order: ORD-123456');
    debugPrint('📱 To token: ${receiver.deviceToken}');

    await sendController.sendOrderNotification(
      deviceToken: receiver.deviceToken!,
      orderStatus: 'shipped',
      orderId: 'ORD-123456',
    );
  }

  void _sendBrandNotification(FCMNotificationSender sendController, FCMNotificationReceiver receiver) async {
    if (receiver.deviceToken == null) {
      Get.snackbar(
        '❌ Error',
        'Device token not available',
        backgroundColor: failColor,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      debugPrint('❌ Cannot send notification: Device token is null');
      return;
    }

    debugPrint('📤 Sending brand notification...');
    debugPrint('🏪 Brand: Test Brand');
    debugPrint('📱 To token: ${receiver.deviceToken}');

    await sendController.sendBrandNotification(
      deviceToken: receiver.deviceToken!,
      brandName: 'Test Brand',
      notificationMessage: 'Check out our new collection! 🎉',
      brandId: 'brand_123',
    );
  }
}