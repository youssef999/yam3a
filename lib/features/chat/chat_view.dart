import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/models/brand.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/core/widgets/custom_appbar.dart';
import 'package:shop_app/features/chat/chat_controller.dart';
import 'package:shop_app/features/chat/widgets/chat_message_bubble.dart';
import 'package:shop_app/features/chat/widgets/chat_input.dart';

class ChatView extends StatefulWidget {
  final Brand brand;

  const ChatView({super.key, required this.brand});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late final ChatController controller;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller = Get.put(ChatController(brand: widget.brand), tag: widget.brand.id);
    
    // Auto-scroll to bottom when new messages arrive
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    if (Get.isRegistered<ChatController>(tag: widget.brand.id)) {
      Get.delete<ChatController>(tag: widget.brand.id);
    }
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(
        'chat_with_brand'.trParams({'brand': widget.brand.name}),
        true,
       
      ),
      body: Column(
        children: [
          // Brand info header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade200,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: widget.brand.image.isNotEmpty
                      ? NetworkImage(widget.brand.image)
                      : null,
                  child: widget.brand.image.isEmpty
                      ? Icon(
                          Icons.storefront,
                          size: 24,
                          color: Colors.grey.shade600,
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Get.locale?.languageCode == 'ar'
                            ? (widget.brand.nameAr.isEmpty ? widget.brand.name : widget.brand.nameAr)
                            : widget.brand.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'online_now'.tr,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.green.shade200,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.circle,
                        size: 8,
                        color: Colors.green.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'active'.tr,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Messages list
          Expanded(
            child: GetBuilder<ChatController>(
              tag: widget.brand.id,
              builder: (controller) {
                if (controller.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (controller.messages.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'no_messages_yet'.tr,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'start_conversation'.tr,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  color: buttonColor,
                  onRefresh: controller.refreshMessages,
                  child: ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      final message = controller.messages[index];
                      return ChatMessageBubble(
                        message: message,
                        isMyMessage: controller.isMyMessage(message),
                        isSystemMessage: controller.isSystemMessage(message),
                        timeText: controller.formatMessageTime(message.timestamp),
                        statusIcon: controller.getMessageStatusIcon(message),
                        statusColor: controller.getMessageStatusColor(message),
                      );
                    },
                  ),
                );
              },
            ),
          ),

          // Message input
          GetBuilder<ChatController>(
            tag: widget.brand.id,
            builder: (controller) {
              return ChatInput(
                controller: controller.messageController,
                isSending: controller.isSending,
                onSend: (message) {
                  controller.sendMessage(message);
                  // Auto-scroll to bottom after sending
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollToBottom();
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }
}