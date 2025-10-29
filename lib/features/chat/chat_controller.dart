import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/models/chat_message.dart';
import 'package:shop_app/core/models/brand.dart';
import 'package:shop_app/core/utils/local_db.dart';

class ChatController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Brand brand;
  final TextEditingController messageController = TextEditingController();
  
  // Chat data
  late String chatId;
  late String currentUserEmail;
  late String currentUserName;
  final List<ChatMessage> messages = <ChatMessage>[].obs;
  StreamSubscription<QuerySnapshot>? _messagesSubscription;
  bool isLoading = false;
  bool isSending = false;

  ChatController({required this.brand});

  @override
  void onInit() {
    super.onInit();
    _initializeChat();
  }

  @override
  void onClose() {
    _messagesSubscription?.cancel();
    messageController.dispose();
    super.onClose();
  }

  void _initializeChat() {
    // Get current user info from local storage
    currentUserEmail = storage.userEmail ?? '';
    currentUserName = storage.userName ?? 'user'.tr;
    
    if (currentUserEmail.isEmpty) {
      Get.snackbar(
        'error'.tr,
        'user_not_logged_in'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
      );
      return;
    }

    // Create chat ID from user and brand emails (consistent ID for the same pair)
    chatId = _generateChatId(currentUserEmail, brand.email);
    
    // Initialize chat room and start listening to messages
    _initializeChatRoom();
    _listenToMessages();
  }

  String _generateChatId(String userEmail, String brandEmail) {
    // Sort emails to ensure consistent chat ID regardless of who initiates
    final emails = [userEmail, brandEmail]..sort();
    return '${emails[0]}_${emails[1]}'.replaceAll('@', '_').replaceAll('.', '_');
  }

  Future<void> _initializeChatRoom() async {
    try {
      final chatRoomRef = _firestore.collection('chat_rooms').doc(chatId);
      final chatRoomDoc = await chatRoomRef.get();

      if (!chatRoomDoc.exists) {
        // Create new chat room
        final chatRoom = ChatRoom(
          id: chatId,
          userEmail: currentUserEmail,
          userName: currentUserName,
          brandEmail: brand.email,
          brandName: brand.name,
          brandImage: brand.image,
          lastActivity: DateTime.now(),
          isActive: true,
        );

        await chatRoomRef.set(chatRoom.toMap());
        
        // Send welcome message
        await _sendSystemMessage('chat_started'.tr);
      }
    } catch (e) {
      debugPrint('Error initializing chat room: $e');
    }
  }

  void _listenToMessages() {
    _messagesSubscription = _firestore
        .collection('chat_messages')
        .where('chatId', isEqualTo: chatId)
        .orderBy('timestamp', descending: true)
        .limit(50)
        .snapshots()
        .listen(
      (snapshot) {
        messages.clear();
        messages.addAll(
          snapshot.docs.map((doc) => ChatMessage.fromDocument(doc)).toList(),
        );
        _markMessagesAsRead();
        update();
      },
      onError: (error) {
        debugPrint('Error listening to messages: $error');
        Get.snackbar(
          'error'.tr,
          'failed_to_load_messages'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[100],
          colorText: Colors.red[800],
        );
      },
    );
  }

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty || isSending) return;

    try {
      isSending = true;
      update();

      final messageId = _firestore.collection('chat_messages').doc().id;
      final chatMessage = ChatMessage(
        id: messageId,
        chatId: chatId,
        senderId: currentUserEmail,
        senderEmail: currentUserEmail,
        senderName: currentUserName,
        receiverId: brand.email,
        receiverEmail: brand.email,
        receiverName: brand.name,
        message: message.trim(),
        timestamp: DateTime.now(),
        type: MessageType.text,
        isRead: false,
      );

      // Add message to Firestore
      await _firestore
          .collection('chat_messages')
          .doc(messageId)
          .set(chatMessage.toMap());

      // Update chat room with last message
      await _updateChatRoom(chatMessage);

      // Clear message input
      messageController.clear();

      // Show success feedback
      Get.snackbar(
        'success'.tr,
        'message_sent'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[100],
        colorText: Colors.green[800],
        duration: const Duration(seconds: 2),
      );

    } catch (e) {
      debugPrint('Error sending message: $e');
      Get.snackbar(
        'error'.tr,
        'failed_to_send_message'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
      );
    } finally {
      isSending = false;
      update();
    }
  }

  Future<void> _sendSystemMessage(String message) async {
    try {
      final messageId = _firestore.collection('chat_messages').doc().id;
      final systemMessage = ChatMessage(
        id: messageId,
        chatId: chatId,
        senderId: 'system',
        senderEmail: 'system@yamaa.app',
        senderName: 'System',
        receiverId: currentUserEmail,
        receiverEmail: currentUserEmail,
        receiverName: currentUserName,
        message: message,
        timestamp: DateTime.now(),
        type: MessageType.system,
        isRead: true,
      );

      await _firestore
          .collection('chat_messages')
          .doc(messageId)
          .set(systemMessage.toMap());

      await _updateChatRoom(systemMessage);
    } catch (e) {
      debugPrint('Error sending system message: $e');
    }
  }

  Future<void> _updateChatRoom(ChatMessage lastMessage) async {
    try {
      await _firestore.collection('chat_rooms').doc(chatId).update({
        'lastMessage': lastMessage.toMap(),
        'lastActivity': Timestamp.fromDate(DateTime.now()),
        'unreadCount': FieldValue.increment(1),
      });
    } catch (e) {
      debugPrint('Error updating chat room: $e');
    }
  }

  Future<void> _markMessagesAsRead() async {
    try {
      final unreadMessages = messages.where(
        (message) => !message.isRead && message.receiverEmail == currentUserEmail,
      );

      if (unreadMessages.isNotEmpty) {
        final batch = _firestore.batch();
        
        for (final message in unreadMessages) {
          batch.update(
            _firestore.collection('chat_messages').doc(message.id),
            {'isRead': true},
          );
        }

        await batch.commit();

        // Reset unread count in chat room
        await _firestore.collection('chat_rooms').doc(chatId).update({
          'unreadCount': 0,
        });
      }
    } catch (e) {
      debugPrint('Error marking messages as read: $e');
    }
  }

  String formatMessageTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'now'.tr;
    }
  }

  String getMessageStatusIcon(ChatMessage message) {
    if (message.senderEmail != currentUserEmail) return '';
    
    return message.isRead ? '✓✓' : '✓';
  }

  Color getMessageStatusColor(ChatMessage message) {
    if (message.senderEmail != currentUserEmail) return Colors.transparent;
    
    return message.isRead ? Colors.blue : Colors.grey;
  }

  bool isMyMessage(ChatMessage message) {
    return message.senderEmail == currentUserEmail;
  }

  bool isSystemMessage(ChatMessage message) {
    return message.type == MessageType.system;
  }

  void scrollToBottom() {
    // This will be called from the view when needed
    update();
  }

  Future<void> refreshMessages() async {
    // Refresh is handled automatically by the stream
    _listenToMessages();
  }
}