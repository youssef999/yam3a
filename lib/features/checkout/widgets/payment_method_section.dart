import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/features/checkout/checkout_controller.dart';

class PaymentMethodSection extends StatelessWidget {
  final CheckoutController controller;

  const PaymentMethodSection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(16), 
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.payment, color: buttonColor, size: 22),
              const SizedBox(width: 10),
              Text('payment_method'.tr, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: txtColor)),
            ],
          ),
          const SizedBox(height: 20),
          _buildPaymentOption(PaymentMethod.cash, 'cash_on_delivery'.tr, '💵', 'pay_when_delivered'.tr),
          const SizedBox(height: 12),
          _buildPaymentOption(PaymentMethod.visa, 'visa_card'.tr, '💳', 'secure_online_payment'.tr),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(PaymentMethod method, String title, String emoji, String subtitle) {
    final isSelected = controller.selectedPaymentMethod == method;

    return GestureDetector(
      onTap: () => controller.selectPaymentMethod(method),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? (buttonColor as Color).withOpacity(0.1) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? buttonColor as Color : Colors.grey.shade300, 
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle, 
                border: Border.all(
                  color: isSelected ? buttonColor as Color : Colors.grey.shade400, 
                  width: 2,
                ),
              ),
              child: isSelected 
                  ? Center(
                      child: Container(
                        width: 12, 
                        height: 12, 
                        decoration: BoxDecoration(shape: BoxShape.circle, color: buttonColor),
                      ),
                    ) 
                  : null,
            ),
            const SizedBox(width: 16),
            Text(emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title, 
                    style: TextStyle(
                      fontSize: 15, 
                      fontWeight: FontWeight.w700, 
                      color: isSelected ? buttonColor : txtColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}