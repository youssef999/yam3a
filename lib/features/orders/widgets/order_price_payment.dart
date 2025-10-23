import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/features/orders/order_model.dart';

class OrderPricePayment extends StatelessWidget {
  final OrderModel order;

  const OrderPricePayment({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPriceSection(),
        const SizedBox(width: 16),
        _buildPaymentMethod(),
      ],
    );
  }

  Widget _buildPriceSection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Payment Status Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _getPaymentStatusColor(order.getPaymentStatusText()).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _getPaymentStatusColor(order.getPaymentStatusText()).withOpacity(0.3),
              ),
            ),
            child: Text(
              order.getPaymentStatusText().tr,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: _getPaymentStatusColor(order.getPaymentStatusText()),
              ),
            ),
          ),
          const SizedBox(height: 8),
          
          // Payment Progress Bar (only if partially paid)
          if (order.isPartiallyPaid) ...[
            Container(
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(2),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: order.paymentPercentage / 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
          
          // Paid Amount (if any payment made)
          if (order.paidAmount > 0) ...[
            Row(
              children: [
                Icon(Icons.check_circle, size: 14, color: Colors.green),
                const SizedBox(width: 4),
                Text(
                  '${'paid_amount'.tr}: BD ${order.paidAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
          ],
          
          // Unpaid Amount (if any remaining)
          if (order.unpaidAmount > 0) ...[
            Row(
              children: [
                Icon(Icons.pending, size: 14, color: Colors.orange[700]),
                const SizedBox(width: 4),
                Text(
                  '${'remaining_amount'.tr}: BD ${order.unpaidAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.orange[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
          ],
          
          // Total Amount
          Text(
            'BD ${order.totalPrice.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getPaymentStatusColor(String status) {
    switch (status) {
      case 'fully_paid':
        return Colors.green;
      case 'partially_paid':
        return Colors.orange;
      case 'not_paid':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildPaymentMethod() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            order.paymentMethod == 'cash' ? Icons.money : Icons.credit_card,
            size: 18,
            color: Colors.grey[700],
          ),
          const SizedBox(width: 6),
          Text(
            order.paymentMethod.toUpperCase(),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
