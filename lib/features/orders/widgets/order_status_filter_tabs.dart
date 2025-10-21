import 'package:flutter/material.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/features/orders/orders_controller.dart';

class OrderStatusFilterTabs extends StatelessWidget {
  final OrdersController controller;

  const OrderStatusFilterTabs({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: OrderStatus.values.map((status) {
          final isSelected = controller.selectedStatus == status;
          final count = controller.getOrderCountByStatus(status);

          return GestureDetector(
            onTap: () => controller.filterOrders(status),
            child: _buildFilterTab(
              isSelected: isSelected,
              status: status,
              count: count,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFilterTab({
    required bool isSelected,
    required OrderStatus status,
    required int count,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: isSelected ? primaryColor : Colors.grey[300]!,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: primaryColor.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          Text(
            controller.getStatusDisplayText(status),
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.white : Colors.grey[700],
            ),
          ),
          if (count > 0) ...[
            const SizedBox(width: 8),
            _buildCountBadge(isSelected: isSelected, count: count),
          ],
        ],
      ),
    );
  }

  Widget _buildCountBadge({
    required bool isSelected,
    required int count,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.white.withOpacity(0.3)
            : primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        count.toString(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.white : primaryColor,
        ),
      ),
    );
  }
}
