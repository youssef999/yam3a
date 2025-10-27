import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/features/review/send_review_controller.dart';
import 'package:shop_app/features/orders/order_model.dart';
import 'package:shop_app/features/review/widgets/index.dart';

class SendReviewView extends StatelessWidget {
  final OrderModel order;

  const SendReviewView({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    Get.put(SendReviewController(order: order));

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: const ReviewAppBar(),
      body: GetBuilder<SendReviewController>(
        builder: (controller) {
          return Column(
            children: [
              ReviewHeader(controller: controller),
              ReviewItemsList(controller: controller),
              SubmitReviewButton(
                controller: controller,
                onSubmit: () => _submitReview(controller),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _submitReview(SendReviewController controller) async {
    final success = await controller.submitReview();
    if (success) {
      // Navigate back to orders
      Get.back();
      Get.back(); // Go back twice to return to orders list
    }
  }
}