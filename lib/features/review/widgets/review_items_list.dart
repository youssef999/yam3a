import 'package:flutter/material.dart';
import 'package:shop_app/features/review/send_review_controller.dart';
import 'package:shop_app/features/review/widgets/item_review_card.dart';

class ReviewItemsList extends StatelessWidget {
  final SendReviewController controller;

  const ReviewItemsList({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.itemReviews.length,
        itemBuilder: (context, index) {
          final itemReview = controller.itemReviews[index];
          return ItemReviewCard(
            controller: controller,
            itemReview: itemReview,
            index: index,
          );
        },
      ),
    );
  }
}