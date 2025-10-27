import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/animations/page_transitions.dart';
import 'package:shop_app/features/orders/order_model.dart';
import 'package:shop_app/features/orders/orders_controller.dart';
import 'package:shop_app/features/orders/order_details_view.dart';
import 'package:shop_app/features/orders/widgets/order_card_header.dart';
import 'package:shop_app/features/orders/widgets/order_brand_info.dart';
import 'package:shop_app/features/orders/widgets/order_price_payment.dart';
import 'package:shop_app/features/orders/widgets/order_action_buttons.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final OrdersController controller;

  const OrderCard({
    super.key,
    required this.order,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AnimatedGet.toWithSlideRight(OrderDetailsView(order: order)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderCardHeader(order: order),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OrderBrandInfo(order: order),
                  const SizedBox(height: 16),
                  Divider(height: 1, color: Colors.grey[200]),
                  const SizedBox(height: 16),
                  OrderPricePayment(order: order),
                  const SizedBox(height: 16),
                  OrderActionButtons(
                    order: order,
                    controller: controller,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
