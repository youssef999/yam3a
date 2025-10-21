import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/features/orders/order_model.dart';
import 'package:shop_app/features/orders/orders_controller.dart';
import 'package:shop_app/features/orders/order_details_view.dart';
import 'package:shop_app/features/orders/widgets/order_cancel_dialog.dart';

class OrderActionButtons extends StatelessWidget {
  final OrderModel order;
  final OrdersController controller;

  const OrderActionButtons({
    super.key,
    required this.order,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildViewDetailsButton(),
        ),
        if (_canCancelOrder()) ...[
          const SizedBox(width: 12),
          Expanded(
            child: _buildCancelButton(context),
          ),
        ],
      ],
    );
  }

  bool _canCancelOrder() {
    return order.status.toLowerCase() == 'pending';
  }

  Widget _buildViewDetailsButton() {
    return OutlinedButton(
      onPressed: () => Get.to(() => OrderDetailsView(order: order)),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: primaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Text(
        'view_details'.tr,
        style: TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _showCancelDialog(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Text('cancel_order'.tr),
    );
  }

  void _showCancelDialog(BuildContext context) {
    OrderCancelDialog.show(
      context: context,
      order: order,
      controller: controller,
    );
  }
}
