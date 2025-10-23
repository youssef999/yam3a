import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/core/widgets/Custom_button.dart';
import 'package:shop_app/core/widgets/custom_appbar.dart';
import 'package:shop_app/features/checkout/checkout_controller.dart';
import 'package:shop_app/features/location/service/location_navigator.dart';

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
                  _buildOrderSummaryCard(controller),
                  const SizedBox(height: 20),
                  _buildDeliveryLocationCard(controller),
                  const SizedBox(height: 20),
                  _buildPaymentMethodSection(controller),
                  const SizedBox(height: 20),
                  _buildPriceSummaryCard(controller),
                  const SizedBox(height: 32),
                  _buildPlaceOrderButton(controller),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOrderSummaryCard(CheckoutController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [(buttonColor as Color).withOpacity(0.1), (buttonColor as Color).withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: (buttonColor as Color).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: buttonColor, borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.shopping_bag, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('order_summary'.tr, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: txtColor)),
                    Text('${controller.items.length} ${controller.orderType == 'service' ? 'services'.tr : 'packages'.tr}', style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(20)),
                child: Text(controller.orderType.toUpperCase(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.blue.shade700)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: Colors.grey.shade300),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.business, size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 8),
                  Text('brand'.tr, style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                ],
              ),
              Text(controller.brandName, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: txtColor)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryLocationCard(CheckoutController controller) {
    final hasLocation = controller.locationData != null;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade300)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on, color: hasLocation ? buttonColor : Colors.grey.shade400, size: 22),
                  const SizedBox(width: 10),
                  Text('delivery_location'.tr, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: txtColor)),
                ],
              ),
              if (hasLocation)
                TextButton.icon(
                  onPressed: () async {
                    await LocationNavigator.navigateToLocationScreen();
                    controller.loadLocationData();
                  },
                  icon: Icon(Icons.edit, size: 16, color: buttonColor),
                  label: Text('edit'.tr, style: TextStyle(fontSize: 13, color: buttonColor, fontWeight: FontWeight.w600)),
                ),
            ],
          ),
          const SizedBox(height: 16),
          if (hasLocation) ...[
            _buildLocationDetailRow(Icons.home, controller.getFormattedAddress()),
            const SizedBox(height: 12),
            _buildLocationDetailRow(Icons.phone, controller.getPhoneNumber()),
          ] else ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.orange.shade200)),
              child: Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: Colors.orange.shade700, size: 24),
                  const SizedBox(width: 12),
                  Expanded(child: Text('no_delivery_location_set'.tr, style: TextStyle(fontSize: 13, color: Colors.orange.shade800, fontWeight: FontWeight.w500))),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async {
                  await LocationNavigator.navigateToLocationScreen();
                  controller.loadLocationData();
                },
                icon: const Icon(Icons.add_location_alt),
                label: Text('add_location'.tr.toUpperCase()),
                style: OutlinedButton.styleFrom(foregroundColor: buttonColor, side: BorderSide(color: buttonColor as Color, width: 2), padding: const EdgeInsets.symmetric(vertical: 14)),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLocationDetailRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: Colors.grey.shade600),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: TextStyle(fontSize: 14, color: txtColor, height: 1.4))),
      ],
    );
  }

  Widget _buildPaymentMethodSection(CheckoutController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade300)),
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
          _buildPaymentOption(controller, PaymentMethod.cash, 'cash_on_delivery'.tr, '💵', 'pay_when_delivered'.tr),
          const SizedBox(height: 12),
          _buildPaymentOption(controller, PaymentMethod.visa, 'visa_card'.tr, '💳', 'secure_online_payment'.tr),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(CheckoutController controller, PaymentMethod method, String title, String emoji, String subtitle) {
    final isSelected = controller.selectedPaymentMethod == method;

    return GestureDetector(
      onTap: () => controller.selectPaymentMethod(method),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? (buttonColor as Color).withOpacity(0.1) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? buttonColor as Color : Colors.grey.shade300, width: isSelected ? 2 : 1),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: isSelected ? buttonColor as Color : Colors.grey.shade400, width: 2)),
              child: isSelected ? Center(child: Container(width: 12, height: 12, decoration: BoxDecoration(shape: BoxShape.circle, color: buttonColor))) : null,
            ),
            const SizedBox(width: 16),
            Text(emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: isSelected ? buttonColor : txtColor)),
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

  Widget _buildPriceSummaryCard(CheckoutController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.green.shade50, Colors.green.shade100], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.shade300, width: 2),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('subtotal'.tr, style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
              Text('BD ${controller.totalPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('delivery_fee'.tr, style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
              Text('FREE', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.green.shade700)),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: Colors.green.shade300, thickness: 2),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('total'.tr, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.green.shade900)),
              Text('BD ${controller.totalPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.green.shade900)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceOrderButton(CheckoutController controller) {
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
              controller.placeOrder().then((success) {
                if (success) {
                  Get.back(result: true);
                  Get.back();
                }
              });
            },
    );
  }
}
