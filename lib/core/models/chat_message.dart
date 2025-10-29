import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String id;
  final String chatId;
  final String senderId;
  final String senderEmail;
  final String senderName;
  final String receiverId;
  final String receiverEmail;
  final String receiverName;
  final String message;
  final DateTime timestamp;
  final MessageType type;
  final bool isRead;
  final Map<String, dynamic>? metadata;

  const ChatMessage({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.senderEmail,
    required this.senderName,
    required this.receiverId,
    required this.receiverEmail,
    required this.receiverName,
    required this.message,
    required this.timestamp,
    this.type = MessageType.text,
    this.isRead = false,
    this.metadata,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chatId': chatId,
      'senderId': senderId,
      'senderEmail': senderEmail,
      'senderName': senderName,
      'receiverId': receiverId,
      'receiverEmail': receiverEmail,
      'receiverName': receiverName,
      'message': message,
      'timestamp': Timestamp.fromDate(timestamp),
      'type': type.toString().split('.').last,
      'isRead': isRead,
      'metadata': metadata,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map, {required String id}) {
    return ChatMessage(
      id: id,
      chatId: map['chatId'] as String? ?? '',
      senderId: map['senderId'] as String? ?? '',
      senderEmail: map['senderEmail'] as String? ?? '',
      senderName: map['senderName'] as String? ?? '',
      receiverId: map['receiverId'] as String? ?? '',
      receiverEmail: map['receiverEmail'] as String? ?? '',
      receiverName: map['receiverName'] as String? ?? '',
      message: map['message'] as String? ?? '',
      timestamp: (map['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      type: MessageType.values.firstWhere(
        (e) => e.toString().split('.').last == map['type'],
        orElse: () => MessageType.text,
      ),
      isRead: map['isRead'] as bool? ?? false,
      metadata: map['metadata'] as Map<String, dynamic>?,
    );
  }

  factory ChatMessage.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    return ChatMessage.fromMap(doc.data() ?? {}, id: doc.id);
  }

  ChatMessage copyWith({
    String? id,
    String? chatId,
    String? senderId,
    String? senderEmail,
    String? senderName,
    String? receiverId,
    String? receiverEmail,
    String? receiverName,
    String? message,
    DateTime? timestamp,
    MessageType? type,
    bool? isRead,
    Map<String, dynamic>? metadata,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      senderEmail: senderEmail ?? this.senderEmail,
      senderName: senderName ?? this.senderName,
      receiverId: receiverId ?? this.receiverId,
      receiverEmail: receiverEmail ?? this.receiverEmail,
      receiverName: receiverName ?? this.receiverName,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      metadata: metadata ?? this.metadata,
    );
  }
}

class ChatRoom {
  final String id;
  final String userEmail;
  final String userName;
  final String brandEmail;
  final String brandName;
  final String brandImage;
  final ChatMessage? lastMessage;
  final DateTime lastActivity;
  final int unreadCount;
  final bool isActive;
  final Map<String, dynamic>? metadata;

  const ChatRoom({
    required this.id,
    required this.userEmail,
    required this.userName,
    required this.brandEmail,
    required this.brandName,
    required this.brandImage,
    this.lastMessage,
    required this.lastActivity,
    this.unreadCount = 0,
    this.isActive = true,
    this.metadata,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userEmail': userEmail,
      'userName': userName,
      'brandEmail': brandEmail,
      'brandName': brandName,
      'brandImage': brandImage,
      'lastMessage': lastMessage?.toMap(),
      'lastActivity': Timestamp.fromDate(lastActivity),
      'unreadCount': unreadCount,
      'isActive': isActive,
      'metadata': metadata,
    };
  }

  factory ChatRoom.fromMap(Map<String, dynamic> map, {required String id}) {
    return ChatRoom(
      id: id,
      userEmail: map['userEmail'] as String? ?? '',
      userName: map['userName'] as String? ?? '',
      brandEmail: map['brandEmail'] as String? ?? '',
      brandName: map['brandName'] as String? ?? '',
      brandImage: map['brandImage'] as String? ?? '',
      lastMessage: map['lastMessage'] != null 
          ? ChatMessage.fromMap(map['lastMessage'] as Map<String, dynamic>, id: 'last_message')
          : null,
      lastActivity: (map['lastActivity'] as Timestamp?)?.toDate() ?? DateTime.now(),
      unreadCount: map['unreadCount'] as int? ?? 0,
      isActive: map['isActive'] as bool? ?? true,
      metadata: map['metadata'] as Map<String, dynamic>?,
    );
  }

  factory ChatRoom.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    return ChatRoom.fromMap(doc.data() ?? {}, id: doc.id);
  }

  ChatRoom copyWith({
    String? id,
    String? userEmail,
    String? userName,
    String? brandEmail,
    String? brandName,
    String? brandImage,
    ChatMessage? lastMessage,
    DateTime? lastActivity,
    int? unreadCount,
    bool? isActive,
    Map<String, dynamic>? metadata,
  }) {
    return ChatRoom(
      id: id ?? this.id,
      userEmail: userEmail ?? this.userEmail,
      userName: userName ?? this.userName,
      brandEmail: brandEmail ?? this.brandEmail,
      brandName: brandName ?? this.brandName,
      brandImage: brandImage ?? this.brandImage,
      lastMessage: lastMessage ?? this.lastMessage,
      lastActivity: lastActivity ?? this.lastActivity,
      unreadCount: unreadCount ?? this.unreadCount,
      isActive: isActive ?? this.isActive,
      metadata: metadata ?? this.metadata,
    );
  }
}

enum MessageType {
  text,
  image,
  file,
  system,
}