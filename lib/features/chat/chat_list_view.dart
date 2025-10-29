import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/core/widgets/custom_appbar.dart';
import 'package:shop_app/core/models/chat_message.dart';
import 'package:shop_app/features/chat/chat_list_controller.dart';
import 'package:shop_app/features/chat/widgets/chat_list_item.dart';

class ChatListView extends StatefulWidget {
  const ChatListView({super.key});

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  late final ChatListController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ChatListController());
  }

  @override
  void dispose() {
    // Don't delete controller here as it might be used by navigation
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(
        'my_chats'.tr,
        true, // No back button since it's a main tab
       
      ),
      body: GetBuilder<ChatListController>(
        builder: (controller) {
          // Loading state
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Error state  
          if (controller.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    controller.errorMessage!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: controller.refreshChats,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: Text('retry'.tr),
                  ),
                ],
              ),
            );
          }

          // Empty state
          if (controller.chatRooms.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 80,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'no_chats_yet'.tr,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'start_chatting_with_brands'.tr,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: buttonColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: buttonColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 16,
                          color: buttonColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'visit_brands_to_chat'.tr,
                          style: TextStyle(
                            fontSize: 12,
                            color: buttonColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          // Chat list
          return RefreshIndicator(
            color: buttonColor,
            onRefresh: controller.refreshChats,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  // Header with chat count
                  // SliverToBoxAdapter(
                  //   child: Container(
                  //     padding: const EdgeInsets.all(16),
                  //     child: Row(
                  //       children: [
                  //         Icon(
                  //           Icons.chat_rounded,
                  //           size: 20,
                  //           color: buttonColor,
                  //         ),
                  //         const SizedBox(width: 8),
                  //         // Text(
                  //         //   'active_chats'.trParams({
                  //         //     'count': controller.chatRooms.length.toString()
                  //         //   }),
                  //         //   style: TextStyle(
                  //         //     fontSize: 14,
                  //         //     color: Colors.grey.shade600,
                  //         //     fontWeight: FontWeight.w500,
                  //         //   ),
                  //         // ),
                  //         const Spacer(),
                  //         if (controller.totalUnreadCount > 0)
                  //           Container(
                  //             padding: const EdgeInsets.symmetric(
                  //               horizontal: 8,
                  //               vertical: 4,
                  //             ),
                  //             decoration: BoxDecoration(
                  //               color: Colors.red.shade500,
                  //               borderRadius: BorderRadius.circular(12),
                  //             ),
                  //             child: Text(
                  //               controller.totalUnreadCount > 99 
                  //                   ? '99+' 
                  //                   : controller.totalUnreadCount.toString(),
                  //               style: const TextStyle(
                  //                 color: Colors.white,
                  //                 fontSize: 11,
                  //                 fontWeight: FontWeight.w600,
                  //               ),
                  //             ),
                  //           ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
              
                  // Chat items
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final chatRoom = controller.chatRooms[index];
                        
                        return ChatListItem(
                          chatRoom: chatRoom,
                          lastMessagePreview: controller.getLastMessagePreview(
                            chatRoom.lastMessage,
                          ),
                          timeText: controller.formatLastMessageTime(
                            chatRoom.lastActivity,
                          ),
                          hasUnreadMessages: controller.hasUnreadMessages(chatRoom),
                          onTap: () => controller.openChat(chatRoom),
                          onLongPress: () => _showChatOptions(chatRoom),
                        );
                      },
                      childCount: controller.chatRooms.length,
                    ),
                  ),
              
                  // Bottom padding
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 100),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showChatOptions(ChatRoom chatRoom) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Brand info
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: chatRoom.brandImage.isNotEmpty
                          ? NetworkImage(chatRoom.brandImage)
                          : null,
                      child: chatRoom.brandImage.isEmpty
                          ? Icon(
                              Icons.storefront,
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
                            chatRoom.brandName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            chatRoom.brandEmail,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Options
              ListTile(
                leading: Icon(
                  Icons.chat,
                  color: buttonColor,
                ),
                title: Text('open_chat'.tr),
                onTap: () {
                  Get.back();
                  controller.openChat(chatRoom);
                },
              ),
              
              ListTile(
                leading: Icon(
                  Icons.delete_outline,
                  color: Colors.red.shade600,
                ),
                title: Text(
                  'delete_chat'.tr,
                  style: TextStyle(color: Colors.red.shade600),
                ),
                onTap: () {
                  Get.back();
                  controller.deleteChat(chatRoom.id);
                },
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}