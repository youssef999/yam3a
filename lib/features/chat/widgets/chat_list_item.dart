import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/models/chat_message.dart';
import 'package:shop_app/core/res/app_colors.dart';

class ChatListItem extends StatelessWidget {
  final ChatRoom chatRoom;
  final String lastMessagePreview;
  final String timeText;
  final bool hasUnreadMessages;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const ChatListItem({
    super.key,
    required this.chatRoom,
    required this.lastMessagePreview,
    required this.timeText,
    required this.hasUnreadMessages,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Brand avatar
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: chatRoom.brandImage.isNotEmpty
                          ? NetworkImage(chatRoom.brandImage)
                          : null,
                      child: chatRoom.brandImage.isEmpty
                          ? Icon(
                              Icons.storefront,
                              size: 28,
                              color: Colors.grey.shade600,
                            )
                          : null,
                    ),
                    // Online indicator
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.green.shade500,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(width: 16),
                
                // Chat details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Brand name and time
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              Get.locale?.languageCode == 'ar'
                                  ? chatRoom.brandName
                                  : chatRoom.brandName,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: hasUnreadMessages 
                                    ? FontWeight.w700 
                                    : FontWeight.w600,
                                color: Colors.black87,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            timeText,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: hasUnreadMessages 
                                  ? FontWeight.w600 
                                  : FontWeight.w400,
                              color: hasUnreadMessages
                                  ? buttonColor
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 4),
                      
                      // Last message and unread indicator
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              lastMessagePreview,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: hasUnreadMessages 
                                    ? FontWeight.w500 
                                    : FontWeight.w400,
                                color: hasUnreadMessages
                                    ? Colors.black87
                                    : Colors.grey.shade600,
                                height: 1.3,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          
                          if (hasUnreadMessages) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: buttonColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                chatRoom.unreadCount > 99 
                                    ? '99+' 
                                    : chatRoom.unreadCount.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}