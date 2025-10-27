import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/features/location/controllers/location_controller.dart';

class CityDropdown extends StatelessWidget {
  final LocationController controller;

  const CityDropdown({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Row(
            children: [
              Icon(Icons.location_city, color: buttonColor, size: 20),
              const SizedBox(width: 12),
              Text(
                'select_city'.tr,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          value: controller.selectedCity,
          icon: Icon(Icons.arrow_drop_down, color: buttonColor),
          items: controller.citiesKeys.map((String cityKey) {
            return DropdownMenuItem<String>(
              value: cityKey,
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: iconColor,
                    size: 18,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    cityKey.tr,
                    style: TextStyle(
                      fontSize: 14,
                      color: txtColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (String? value) {
            controller.selectCity(value);
          },
        ),
      ),
    );
  }
}