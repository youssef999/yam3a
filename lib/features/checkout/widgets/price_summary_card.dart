import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/features/checkout/checkout_controller.dart';

class PriceSummaryCard extends StatelessWidget {
  final CheckoutController controller;

  const PriceSummaryCard({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final hasMinimumOrderDifference = controller.actualTotalPrice != controller.totalPrice;
    final unpaidAmount = controller.actualTotalPrice - controller.totalPrice;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade50, Colors.green.shade100], 
          begin: Alignment.topLeft, 
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.shade300, width: 2),
      ),
      child: Column(
        children: [
          // Original Order Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('order_total'.tr, style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
              Text('BD ${controller.actualTotalPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
            ],
          ),
          
          // Show minimum order breakdown if applicable
          if (hasMinimumOrderDifference) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.orange.shade700, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'minimum_order_policy'.tr,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.orange.shade800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('paid_now'.tr, style: TextStyle(fontSize: 13, color: Colors.orange.shade700, fontWeight: FontWeight.w600)),
                      Text('BD ${controller.totalPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 13, color: Colors.orange.shade700, fontWeight: FontWeight.w700)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('remaining_balance'.tr, style: TextStyle(fontSize: 13, color: Colors.orange.shade700)),
                      Text('BD ${unpaidAmount.toStringAsFixed(2)}', style: TextStyle(fontSize: 13, color: Colors.orange.shade700)),
                    ],
                  ),
                ],
              ),
            ),
          ],
          
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('delivery_fee'.tr, style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
              Text('FREE', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.green.shade700)),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: Colors.green.shade300, thickness: 2),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('amount_to_pay'.tr, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.green.shade900)),
              Text('BD ${controller.totalPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.green.shade900)),
            ],
          ),
        ],
      ),
    );
  }
}