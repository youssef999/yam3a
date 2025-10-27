import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/core/widgets/custom_appbar.dart';
import 'package:shop_app/features/checkout/checkout_controller.dart';
import 'package:shop_app/features/checkout/widgets/order_summary_card.dart';
import 'package:shop_app/features/checkout/widgets/delivery_location_card.dart';
import 'package:shop_app/features/checkout/widgets/payment_method_section.dart';
import 'package:shop_app/features/checkout/widgets/price_summary_card.dart';
import 'package:shop_app/features/checkout/widgets/place_order_button.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<CheckoutController>()) {
      Get.put(CheckoutController());
    }
  }

  @override
  void dispose() {
    if (Get.isRegistered<CheckoutController>()) {
      Get.delete<CheckoutController>();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar('checkout'.tr, true),
      body: GetBuilder<CheckoutController>(
        builder: (controller) {
          if (controller.isLoadingLocation) {
            return Center(child: CircularProgressIndicator(color: buttonColor));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OrderSummaryCard(controller: controller),
                  const SizedBox(height: 20),
                  DeliveryLocationCard(controller: controller),
                  const SizedBox(height: 20),
                  PaymentMethodSection(controller: controller),
                  const SizedBox(height: 20),
                  PriceSummaryCard(controller: controller),
                  const SizedBox(height: 32),
                  PlaceOrderButton(controller: controller),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
