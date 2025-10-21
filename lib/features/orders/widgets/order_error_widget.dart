import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/features/orders/orders_controller.dart';

class OrderErrorWidget extends StatelessWidget {
  final OrdersController controller;

  const OrderErrorWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildErrorIcon(),
          const SizedBox(height: 16),
          _buildErrorMessage(),
          const SizedBox(height: 24),
          _buildRetryButton(),
        ],
      ),
    );
  }

  Widget _buildErrorIcon() {
    return Icon(
      Icons.error_outline,
      size: 64,
      color: Colors.grey[400],
    );
  }

  Widget _buildErrorMessage() {
    return Text(
      controller.errorMessage,
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey[600],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildRetryButton() {
    return ElevatedButton.icon(
      onPressed: () => controller.loadOrders(),
      icon: const Icon(Icons.refresh),
      label: Text('retry'.tr),
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
      ),
    );
  }
}
