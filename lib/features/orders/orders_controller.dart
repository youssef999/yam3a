import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/utils/local_db.dart';
import 'package:shop_app/core/utils/app_message.dart';
import 'package:shop_app/features/orders/order_model.dart';

enum OrderStatus { all, pending, accepted, done, canceled }

class OrdersController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  List<OrderModel> allOrders = [];
  List<OrderModel> filteredOrders = [];
  OrderStatus selectedStatus = OrderStatus.all;
  
  bool isLoading = false;
  bool hasError = false;
  String errorMessage = '';
  
  @override
  void onInit() {
    super.onInit();
    loadOrders();
  }
  
  Future<void> loadOrders() async {
    try {
      isLoading = true;
      hasError = false;
      update();
      
      final userEmail = storage.userEmail;
      
      if (userEmail == null || userEmail.isEmpty) {
        hasError = true;
        errorMessage = 'user_email_required'.tr;
        isLoading = false;
        update();
        return;
      }
      
      final querySnapshot = await _firestore
          .collection('orders')
          .where('userEmail', isEqualTo: userEmail)
          .orderBy('createdAt', descending: true)
          .get();
      
      allOrders = querySnapshot.docs
          .map((doc) => OrderModel.fromFirestore(doc))
          .toList();
      
      filterOrders(selectedStatus);
      
      if (kDebugMode) {
        print('📦 Loaded ${allOrders.length} orders');
      }
    } catch (e) {
      hasError = true;
      errorMessage = 'failed_to_load_orders'.tr;
      
      if (kDebugMode) {
        print('❌ Error loading orders: $e');
      }
    } finally {
      isLoading = false;
      update();
    }
  }
  
  void filterOrders(OrderStatus status) {
    selectedStatus = status;
    
    if (status == OrderStatus.all) {
      filteredOrders = List.from(allOrders);
    } else {
      final statusString = _getStatusString(status);
      filteredOrders = allOrders
          .where((order) => order.status.toLowerCase() == statusString.toLowerCase())
          .toList();
    }
    
    update();
    
    if (kDebugMode) {
      print('🔍 Filtered to ${filteredOrders.length} orders with status: ${status.name}');
    }
  }
  
  String _getStatusString(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'pending';
      case OrderStatus.accepted:
        return 'accepted';
      case OrderStatus.done:
        return 'done';
      case OrderStatus.canceled:
        return 'canceled';
      case OrderStatus.all:
        return 'all';
    }
  }
  
  Future<void> updateOrderStatus(String orderId, String newStatus, BuildContext context) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({
        'status': newStatus,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      
      // Update local list
      final index = allOrders.indexWhere((order) => order.id == orderId);
      if (index != -1) {
        allOrders[index] = OrderModel(
          id: allOrders[index].id,
          userId: allOrders[index].userId,
          userEmail: allOrders[index].userEmail,
          userName: allOrders[index].userName,
          orderType: allOrders[index].orderType,
          orderDate: allOrders[index].orderDate,
          totalPrice: allOrders[index].totalPrice,
          status: newStatus,
          paymentMethod: allOrders[index].paymentMethod,
          paymentStatus: allOrders[index].paymentStatus,
          deliveryLocation: allOrders[index].deliveryLocation,
          brandName: allOrders[index].brandName,
          brandEmail: allOrders[index].brandEmail,
          brandImage: allOrders[index].brandImage,
          items: allOrders[index].items,
          itemsCount: allOrders[index].itemsCount,
          createdAt: allOrders[index].createdAt,
          updatedAt: Timestamp.now(),
        );
      }
      
      filterOrders(selectedStatus);
      
      appMessageSuccess(
        text: 'order_status_updated'.tr,
        context: context,
      );
      
      if (kDebugMode) {
        print('✅ Order $orderId status updated to $newStatus');
      }
    } catch (e) {
      appMessageFail(
        text: 'failed_to_update_order'.tr,
        context: context,
      );
      
      if (kDebugMode) {
        print('❌ Error updating order status: $e');
      }
    }
  }
  
  Future<void> cancelOrder(String orderId, BuildContext context) async {
    await updateOrderStatus(orderId, 'canceled', context);
  }
  
  int getOrderCountByStatus(OrderStatus status) {
    if (status == OrderStatus.all) {
      return allOrders.length;
    }
    
    final statusString = _getStatusString(status);
    return allOrders
        .where((order) => order.status.toLowerCase() == statusString.toLowerCase())
        .length;
  }
  
  String getStatusDisplayText(OrderStatus status) {
    switch (status) {
      case OrderStatus.all:
        return 'all_orders'.tr;
      case OrderStatus.pending:
        return 'order_pending'.tr;
      case OrderStatus.accepted:
        return 'order_accepted'.tr;
      case OrderStatus.done:
        return 'order_completed'.tr;
      case OrderStatus.canceled:
        return 'order_canceled'.tr;
    }
  }
  
  Future<void> refreshOrders() async {
    await loadOrders();
  }

  // Check if an order has been reviewed
  Future<bool> isOrderReviewed(String orderId) async {
    try {
      final querySnapshot = await _firestore
          .collection('reviews')
          .where('orderId', isEqualTo: orderId)
          .limit(1)
          .get();
      
      final hasReview = querySnapshot.docs.isNotEmpty;
      
      if (kDebugMode) {
        print('📝 Order $orderId review status: ${hasReview ? "Reviewed" : "Not reviewed"}');
      }
      
      return hasReview;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error checking review status for order $orderId: $e');
      }
      return false; // Default to not reviewed if there's an error
    }
  }
}
