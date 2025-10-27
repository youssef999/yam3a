import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/core/widgets/custom_textformfield.dart';
import 'package:shop_app/features/location/controllers/location_controller.dart';

class ContactFormSection extends StatelessWidget {
  final LocationController controller;

  const ContactFormSection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField.phone(
          hint: 'enter_phone'.tr,
          label: 'phone'.tr,
          controller: controller.phoneController,
          color: buttonColor,
        ),
        CustomTextFormField(
          hint: 'enter_notes'.tr,
          label: 'additional_notes'.tr,
          prefixIcon: Icons.note,
          controller: controller.notesController,
          obs: false,
          color: buttonColor,
          max: 3,
        ),
      ],
    );
  }
}