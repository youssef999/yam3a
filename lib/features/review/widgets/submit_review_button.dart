import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/features/review/send_review_controller.dart';

class SubmitReviewButton extends StatelessWidget {
  final SendReviewController controller;
  final VoidCallback onSubmit;

  const SubmitReviewButton({
    super.key,
    required this.controller,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: controller.canSubmitReview && !controller.isSubmittingReview
              ? onSubmit
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: controller.canSubmitReview ? 8 : 0,
          ),
          child: controller.isSubmittingReview
              ? _buildLoadingContent()
              : _buildSubmitContent(),
        ),
      ),
    );
  }

  Widget _buildLoadingContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'submitting_review'.tr,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.send_rounded,
          color: Colors.white,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          'submit_review'.tr,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}