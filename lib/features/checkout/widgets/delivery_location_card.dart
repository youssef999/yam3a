import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/features/checkout/checkout_controller.dart';
import 'package:shop_app/features/location/service/location_navigator.dart';

class DeliveryLocationCard extends StatelessWidget {
  final CheckoutController controller;

  const DeliveryLocationCard({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final hasLocation = controller.locationData != null;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(16), 
        border: Border.all(color: Colors.grey.shade300),
      ),
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
              decoration: BoxDecoration(
                color: Colors.orange.shade50, 
                borderRadius: BorderRadius.circular(12), 
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: Colors.orange.shade700, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'no_delivery_location_set'.tr, 
                      style: TextStyle(fontSize: 13, color: Colors.orange.shade800, fontWeight: FontWeight.w500),
                    ),
                  ),
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
                style: OutlinedButton.styleFrom(
                  foregroundColor: buttonColor, 
                  side: BorderSide(color: buttonColor as Color, width: 2), 
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
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
        Expanded(
          child: Text(
            text, 
            style: TextStyle(fontSize: 14, color: txtColor, height: 1.4),
          ),
        ),
      ],
    );
  }
}