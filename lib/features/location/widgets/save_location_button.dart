import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/core/widgets/Custom_button.dart';
import 'package:shop_app/features/location/controllers/location_controller.dart';

class SaveLocationButton extends StatelessWidget {
  final LocationController controller;

  const SaveLocationButton({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: controller.isLoading
          ? CircularProgressIndicator(color: buttonColor)
          : CustomButton(
              text: 'save_location'.tr.toUpperCase(),
              width: double.infinity,
              onPressed: () async {
                final success = await controller.saveLocation();
                if (success) Get.back();
              },
            ),
    );
  }
}