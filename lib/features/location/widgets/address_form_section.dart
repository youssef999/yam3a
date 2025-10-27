import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/core/widgets/custom_textformfield.dart';
import 'package:shop_app/features/location/controllers/location_controller.dart';

class AddressFormSection extends StatelessWidget {
  final LocationController controller;

  const AddressFormSection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          hint: 'enter_area'.tr,
          label: 'area_district'.tr,
          prefixIcon: Icons.location_city,
          controller: controller.areaController,
          obs: false,
          color: buttonColor,
        ),
        CustomTextFormField(
          hint: 'enter_floor'.tr,
          label: 'floor'.tr,
          prefixIcon: Icons.layers,
          controller: controller.floorController,
          obs: false,
          color: buttonColor,
          type: TextInputType.number,
        ),
        CustomTextFormField(
          hint: 'enter_apartment'.tr,
          label: 'apartment_number'.tr,
          prefixIcon: Icons.door_front_door,
          controller: controller.apartmentController,
          obs: false,
          color: buttonColor,
          type: TextInputType.number,
        ),
      ],
    );
  }
}