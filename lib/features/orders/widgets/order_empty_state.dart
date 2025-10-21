import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/features/orders/orders_controller.dart';

class OrderEmptyState extends StatelessWidget {
  final OrderStatus selectedStatus;

  const OrderEmptyState({
    super.key,
    required this.selectedStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'no_orders_found'.tr,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            selectedStatus == OrderStatus.all
                ? 'no_orders_description'.tr
                : 'no_orders_for_status'.tr,
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
}
