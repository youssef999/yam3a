import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/core/widgets/Custom_button.dart';
import 'package:shop_app/features/checkout/checkout_controller.dart';

class PlaceOrderButton extends StatelessWidget {
  final CheckoutController controller;

  const PlaceOrderButton({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final hasLocation = controller.locationData != null;

    if (controller.isLoading) {
      return Center(child: CircularProgressIndicator(color: buttonColor));
    }

    return CustomButton(
      text: 'place_order'.tr.toUpperCase(),
      width: double.infinity,
      onPressed: !hasLocation
          ? () {}
          : () {
              controller.placeOrder();
              // .then((success) {
              //   if (success) {
              //     Get.back(result: true);
              //     Get.back();
              //   }
              // });
            },
    );
  }
}