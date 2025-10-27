import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/core/widgets/custom_appbar.dart';
import 'package:shop_app/core/widgets/Custom_button.dart';
import 'package:shop_app/features/notifications/noti_controller.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  void initState() {
    super.initState();
    final controller = Get.put(NotificationController());
    // Mark all notifications as read when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.markAllAsRead();
    });
  }

  @override
  void dispose() {
    if (Get.isRegistered<NotificationController>()) {
      Get.delete<NotificationController>();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar('notifications'.tr, true),
      body: GetBuilder<NotificationController>(
        builder: (controller) {
          return RefreshIndicator(
            color: buttonColor,
            onRefresh: controller.fetchNotifications,
            child: Column(
              children: [
                // Notifications List
                Expanded(
                  child: _buildNotificationsList(controller),
                ),
              ],
            ),
          );
        },
      ),
    );
  }



  Widget _buildNotificationsList(NotificationController controller) {
    if (controller.isLoading && controller.notifications.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (controller.errorMessage != null && controller.notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red[400],
            ),
            const SizedBox(height: 16),
            Text(
              'error_loading_notifications'.tr,
              style: TextStyle(
                fontSize: 16,
                color: Colors.red[600],
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              controller.errorMessage ?? '',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'retry'.tr,
              onPressed: controller.fetchNotifications,
            ),
          ],
        ),
      );
    }

    if (controller.notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'no_notifications'.tr,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'no_notifications_desc'.tr,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: controller.notifications.length,
      itemBuilder: (context, index) {
        final notification = controller.notifications[index];
        return _buildNotificationItem(controller, notification, index);
      },
    );
  }

  Widget _buildNotificationItem(
    NotificationController controller,
    Map<String, dynamic> notification,
    int index,
  ) {
    final isRead = notification['isRead'] ?? false;
    final type = notification['type'] ?? 'general';
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isRead ? const Color(0xFFFAFAFA) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isRead ? const Color(0xFFE5E7EB) : const Color(0xFFE2E8F0), 
          width: 1
        ),
        boxShadow: [
          BoxShadow(
            color: isRead 
                ? Colors.black.withOpacity(0.04) 
                : Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: _buildNotificationIcon(type, isRead),
        title: Text(
          notification['title'] ?? 'no_title'.tr,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isRead ? FontWeight.w500 : FontWeight.w600,
            color: isRead ? const Color(0xFF6B7280) : const Color(0xFF1F2937),
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              notification['message'] ?? 'no_message'.tr,
              style: TextStyle(
                fontSize: 14,
                color: isRead ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                height: 1.4,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  size: 14,
                  color: Color(0xFF9CA3AF),
                ),
                const SizedBox(width: 4),
                Text(
                  controller.getFormattedDateTime(notification['dateTime']),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9CA3AF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                if (!isRead)
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2563EB),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2563EB).withOpacity(0.3),
                          blurRadius: 3,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
        onTap: () {
          if (!isRead) {
            controller.markAsRead(notification['id']);
          }
          _showNotificationDetails(notification);
        },

      ),
    );
  }

  Widget _buildNotificationIcon(String type, bool isRead) {
    IconData icon;
    Color color;
    Color backgroundColor;

    // Professional color palette
    const Color professionalBlue = Color(0xFF2563EB);
    const Color professionalGreen = Color(0xFF059669);
    const Color professionalOrange = Color(0xFFEA580C);
    const Color professionalPurple = Color(0xFF7C3AED);
    const Color professionalGrey = Color(0xFF6B7280);

    switch (type) {
      case 'order':
        icon = Icons.notifications_active;
        color = isRead ? professionalGrey : professionalBlue;
        backgroundColor = isRead ? Colors.grey[100]! : const Color(0xFFF0F7FF);
        break;
      case 'promotion':
        icon = Icons.campaign;
        color = isRead ? professionalGrey : professionalOrange;
        backgroundColor = isRead ? Colors.grey[100]! : const Color(0xFFFEF3E2);
        break;
      case 'test':
        icon = Icons.notifications;
        color = isRead ? professionalGrey : professionalPurple;
        backgroundColor = isRead ? Colors.grey[100]! : const Color(0xFFF5F3FF);
        break;
      case 'system':
        icon = Icons.settings;
        color = isRead ? professionalGrey : professionalGreen;
        backgroundColor = isRead ? Colors.grey[100]! : const Color(0xFFECFDF5);
        break;
      default:
        icon = Icons.notifications;
        color = isRead ? professionalGrey : professionalBlue;
        backgroundColor = isRead ? Colors.grey[100]! : const Color(0xFFF0F7FF);
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.15),
          width: 1,
        ),
      ),
      child: Icon(
        icon,
        color: color,
        size: 20,
      ),
    );
  }

  void _showNotificationDetails(Map<String, dynamic> notification) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(notification['title'] ?? 'no_title'.tr),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                notification['message'] ?? 'no_message'.tr,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Text(
                'notification_details'.tr,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('${'notification_type'.tr}: ${notification['type'] ?? 'general'}'),
              Text('${'notification_email'.tr}: ${notification['email'] ?? 'unknown'}'),
              Text('${'read_status'.tr}: ${notification['isRead'] == true ? 'notification_read'.tr : 'notification_unread'.tr}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('close'.tr),
          ),
        ],
      ),
    );
  }




}
