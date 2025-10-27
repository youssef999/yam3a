import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/core/animations/page_transitions.dart';
import 'package:shop_app/features/orders/order_model.dart';
import 'package:shop_app/features/orders/orders_controller.dart';
import 'package:shop_app/features/orders/order_details_view.dart';
import 'package:shop_app/features/orders/widgets/order_cancel_dialog.dart';
import 'package:shop_app/features/review/send_review_view.dart';

class OrderActionButtons extends StatefulWidget {
  final OrderModel order;
  final OrdersController controller;

  const OrderActionButtons({
    super.key,
    required this.order,
    required this.controller,
  });

  @override
  State<OrderActionButtons> createState() => _OrderActionButtonsState();
}

class _OrderActionButtonsState extends State<OrderActionButtons> {
  bool isLoadingReviewStatus = false;
  bool? isReviewed;

  @override
  void initState() {
    super.initState();
    if (_canReviewOrder()) {
      _checkReviewStatus();
    }
  }

  Future<void> _checkReviewStatus() async {
    if (widget.order.id == null) return;
    
    setState(() {
      isLoadingReviewStatus = true;
    });
    
    final reviewed = await widget.controller.isOrderReviewed(widget.order.id!);
    
    if (mounted) {
      setState(() {
        isReviewed = reviewed;
        isLoadingReviewStatus = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
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
        ),
        if (_canReviewOrder()) ...[
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: _buildReviewWidget(),
          ),
        ],
      ],
    );
  }

  bool _canCancelOrder() {
    return widget.order.status.toLowerCase() == 'pending';
  }

  bool _canReviewOrder() {
    final status = widget.order.status.toLowerCase();
    return status == 'done' || status == 'completed';
  }

  Widget _buildViewDetailsButton() {
    return OutlinedButton(
      onPressed: () => AnimatedGet.toWithSlideRight(OrderDetailsView(order: widget.order)),
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

  Widget _buildReviewWidget() {
    if (isLoadingReviewStatus) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[400]!),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'checking_review_status'.tr,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    if (isReviewed == true) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.green[200]!),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.green[600],
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'review_submitted'.tr,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.green[700],
              ),
            ),
          ],
        ),
      );
    }

    return _buildReviewButton();
  }

  Widget _buildReviewButton() {
    return ElevatedButton.icon(
      onPressed: () => AnimatedGet.toWithSlideUp(SendReviewView(order: widget.order)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        elevation: 4,
      ),
      icon: const Icon(Icons.star_border_rounded, size: 20),
      label: Text(
        'rate_and_review'.tr,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }

  void _showCancelDialog(BuildContext context) {
    OrderCancelDialog.show(
      context: context,
      order: widget.order,
      controller: widget.controller,
    );
  }
}
