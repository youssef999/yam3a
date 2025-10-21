import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/features/orders/order_model.dart';
import 'package:shop_app/features/orders/widgets/order_status_helpers.dart';

class OrderCardHeader extends StatelessWidget {
  final OrderModel order;

  const OrderCardHeader({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = OrderStatusHelpers.getStatusColor(order.status);
    final statusIcon = OrderStatusHelpers.getStatusIcon(order.status);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          _buildStatusIconContainer(statusColor, statusIcon),
          const SizedBox(width: 12),
          Expanded(
            child: _buildOrderInfo(),
          ),
          _buildStatusBadge(statusColor),
        ],
      ),
    );
  }

  Widget _buildStatusIconContainer(Color statusColor, IconData statusIcon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(statusIcon, color: statusColor, size: 20),
    );
  }

  Widget _buildOrderInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'order'.tr + ' #${order.id?.substring(0, 8) ?? ''}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${order.getFormattedDate()} • ${order.getFormattedTime()}',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(Color statusColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        order.getStatusText().tr,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
