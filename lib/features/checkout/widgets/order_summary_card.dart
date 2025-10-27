import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/features/checkout/checkout_controller.dart';

class OrderSummaryCard extends StatelessWidget {
  final CheckoutController controller;

  const OrderSummaryCard({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [(buttonColor as Color).withOpacity(0.1), (buttonColor as Color).withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: (buttonColor as Color).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: buttonColor, borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.shopping_bag, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('order_summary'.tr, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: txtColor)),
                    Text('${controller.items.length} ${controller.orderType == 'service' ? 'services'.tr : 'packages'.tr}', style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(20)),
                child: Text(controller.orderType.toUpperCase(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.blue.shade700)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: Colors.grey.shade300),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.business, size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 8),
                  Text('brand'.tr, style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                ],
              ),
              Text(controller.brandName, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: txtColor)),
            ],
          ),
        ],
      ),
    );
  }
}