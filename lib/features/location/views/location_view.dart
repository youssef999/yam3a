import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/core/widgets/custom_appbar.dart';
import 'package:shop_app/features/location/controllers/location_controller.dart';
import 'package:shop_app/features/location/widgets/index.dart';

class LocationView extends StatefulWidget {
  const LocationView({super.key});

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  @override
  void initState() {
    super.initState();
    Get.put(LocationController());
  }

  @override
  void dispose() {
    if (Get.isRegistered<LocationController>()) {
      Get.delete<LocationController>();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar('location'.tr, true),
      body: Stack(
        children: [
          GetBuilder<LocationController>(
            builder: (controller) {
              if (controller.isLoadingSavedLocation) {
                return Center(child: CircularProgressIndicator(color: buttonColor));
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.hasExistingLocation) 
                        ExistingLocationCard(controller: controller),
                      SectionHeader(
                        icon: Icons.location_on, 
                        title: 'location_details'.tr,
                      ),
                      const SizedBox(height: 20),
                      CityDropdown(controller: controller),
                      const SizedBox(height: 16),
                      const MapButton(),
                      if (controller.latitude != null && controller.longitude != null)
                        const LocationSuccessMessage(),
                      const SizedBox(height: 24),
                      SectionHeader(
                        icon: Icons.home, 
                        title: 'address_details'.tr,
                      ),
                      const SizedBox(height: 16),
                      AddressFormSection(controller: controller),
                      const SizedBox(height: 24),
                      SectionHeader(
                        icon: Icons.contact_phone, 
                        title: 'contact_notes'.tr,
                      ),
                      const SizedBox(height: 16),
                      ContactFormSection(controller: controller),
                      const SizedBox(height: 32),
                      SaveLocationButton(controller: controller),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          ),
          const FloatingYamaaButton(),
        ],
      ),
    );
  }
}
