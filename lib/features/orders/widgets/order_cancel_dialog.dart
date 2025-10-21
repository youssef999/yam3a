import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/features/orders/order_model.dart';
import 'package:shop_app/features/orders/orders_controller.dart';

class OrderCancelDialog extends StatelessWidget {
  final OrderModel order;
  final OrdersController controller;

  const OrderCancelDialog({
    super.key,
    required this.order,
    required this.controller,
  });

  static void show({
    required BuildContext context,
    required OrderModel order,
    required OrdersController controller,
  }) {
    Get.dialog(
      OrderCancelDialog(
        order: order,
        controller: controller,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildWarningIcon(),
            const SizedBox(height: 20),
            _buildTitle(),
            const SizedBox(height: 12),
            _buildMessage(),
            const SizedBox(height: 24),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWarningIcon() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.warning_amber_rounded,
        color: Colors.red,
        size: 48,
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'cancel_order_title'.tr,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildMessage() {
    return Text(
      'cancel_order_message'.tr,
      style: TextStyle(
        fontSize: 15,
        color: Colors.grey[600],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildNoButton(),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildYesButton(context),
        ),
      ],
    );
  }

  Widget _buildNoButton() {
    return OutlinedButton(
      onPressed: () => Get.back(),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text('no'.tr),
    );
  }

  Widget _buildYesButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Get.back();
        controller.cancelOrder(order.id!, context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text('yes_cancel'.tr),
    );
  }
}
