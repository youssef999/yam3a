import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/models/chat_message.dart';
import 'package:shop_app/core/utils/local_db.dart';
import 'package:shop_app/features/chat/chat_view.dart';
import 'package:shop_app/core/models/brand.dart';

class ChatListController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Chat data
  final List<ChatRoom> chatRooms = <ChatRoom>[].obs;
  StreamSubscription<QuerySnapshot>? _chatRoomsSubscription;
  bool isLoading = false;
  String? errorMessage;
  late String currentUserEmail;

  @override
  void onInit() {
    super.onInit();
    _initializeUser();
  }

  @override
  void onClose() {
    _chatRoomsSubscription?.cancel();
    super.onClose();
  }

  void _initializeUser() {
    currentUserEmail = storage.userEmail ?? '';
    
    if (currentUserEmail.isEmpty) {
      errorMessage = 'user_not_logged_in'.tr;
      update();
      return;
    }

    _listenToChatRooms();
  }

  void _listenToChatRooms() {
    try {
      isLoading = true;
      update();

      _chatRoomsSubscription = _firestore
          .collection('chat_rooms')
          .where('userEmail', isEqualTo: currentUserEmail)
          .orderBy('lastActivity', descending: true)
          .snapshots()
          .listen(
        (snapshot) {
          chatRooms.clear();
          chatRooms.addAll(
            snapshot.docs.map((doc) => ChatRoom.fromDocument(doc)).toList(),
          );
          
          isLoading = false;
          errorMessage = null;
          update();
        },
        onError: (error) {
          debugPrint('Error listening to chat rooms: $error');
          errorMessage = 'failed_to_load_chats'.tr;
          isLoading = false;
          update();
        },
      );
    } catch (e) {
      debugPrint('Error initializing chat rooms listener: $e');
      errorMessage = 'failed_to_load_chats'.tr;
      isLoading = false;
      update();
    }
  }

  /// Navigate to individual chat with brand
  Future<void> openChat(ChatRoom chatRoom) async {
    try {
      // Create brand object from chat room data
      final brand = Brand(
        id: chatRoom.brandEmail,
        name: chatRoom.brandName,
        nameAr: chatRoom.brandName, // Fallback to same name
        image: chatRoom.brandImage,
        email: chatRoom.brandEmail,
        phone: '', // Not available in chat room
        description: '',
        descriptionEn: '',
        category: '',
        categoryEn: '',
      );

      // Navigate to chat view
      await Get.to(
        () => ChatView(brand: brand),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 300),
      );

      // Mark messages as read when returning from chat
      await _markChatAsRead(chatRoom.id);
      
    } catch (e) {
      debugPrint('Error opening chat: $e');
      Get.snackbar(
        'error'.tr,
        'failed_to_open_chat'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
      );
    }
  }

  /// Mark all messages in a chat as read
  Future<void> _markChatAsRead(String chatId) async {
    try {
      await _firestore.collection('chat_rooms').doc(chatId).update({
        'unreadCount': 0,
      });
    } catch (e) {
      debugPrint('Error marking chat as read: $e');
    }
  }

  /// Delete a chat room
  Future<void> deleteChat(String chatId) async {
    try {
      // Show confirmation dialog
      final confirmed = await Get.dialog<bool>(
        AlertDialog(
          title: Text('delete_chat'.tr),
          content: Text('delete_chat_confirmation'.tr),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: Text('cancel'.tr),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text('delete'.tr),
            ),
          ],
        ),
      ) ?? false;

      if (!confirmed) return;

      // Delete chat room
      await _firestore.collection('chat_rooms').doc(chatId).delete();

      // Delete all messages in the chat
      final messagesSnapshot = await _firestore
          .collection('chat_messages')
          .where('chatId', isEqualTo: chatId)
          .get();

      final batch = _firestore.batch();
      for (final doc in messagesSnapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();

      Get.snackbar(
        'success'.tr,
        'chat_deleted_successfully'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[100],
        colorText: Colors.green[800],
      );

    } catch (e) {
      debugPrint('Error deleting chat: $e');
      Get.snackbar(
        'error'.tr,
        'failed_to_delete_chat'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
      );
    }
  }

  /// Refresh chat rooms
  Future<void> refreshChats() async {
    _listenToChatRooms();
  }

  /// Format last message time
  String formatLastMessageTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays == 0) {
      // Today - show time
      final hour = timestamp.hour.toString().padLeft(2, '0');
      final minute = timestamp.minute.toString().padLeft(2, '0');
      return '$hour:$minute';
    } else if (difference.inDays == 1) {
      // Yesterday
      return 'yesterday'.tr;
    } else if (difference.inDays < 7) {
      // This week - show day name
      final days = [
        'monday'.tr, 'tuesday'.tr, 'wednesday'.tr, 'thursday'.tr,
        'friday'.tr, 'saturday'.tr, 'sunday'.tr
      ];
      return days[timestamp.weekday - 1];
    } else {
      // Older - show date
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }

  /// Get preview of last message
  String getLastMessagePreview(ChatMessage? lastMessage) {
    if (lastMessage == null) return 'no_messages'.tr;
    
    if (lastMessage.type == MessageType.system) {
      return lastMessage.message;
    }
    
    final isMyMessage = lastMessage.senderEmail == currentUserEmail;
    final prefix = isMyMessage ? 'you'.tr + ': ' : '';
    
    if (lastMessage.message.length > 40) {
      return prefix + lastMessage.message.substring(0, 40) + '...';
    }
    
    return prefix + lastMessage.message;
  }

  /// Get total unread count for badge
  int get totalUnreadCount {
    return chatRooms.fold(0, (sum, chat) => sum + chat.unreadCount);
  }

  /// Check if chat room has unread messages
  bool hasUnreadMessages(ChatRoom chatRoom) {
    return chatRoom.unreadCount > 0;
  }
}