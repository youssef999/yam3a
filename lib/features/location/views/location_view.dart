import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/core/widgets/Custom_button.dart';
import 'package:shop_app/core/widgets/custom_appbar.dart';
import 'package:shop_app/core/widgets/custom_textformfield.dart';
import 'package:shop_app/features/location/controllers/location_controller.dart';
import 'package:shop_app/features/location/views/map_view.dart';
import 'package:shop_app/features/main_nav_bar/main_nav_bar.dart';

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
                      if (controller.hasExistingLocation) _buildExistingLocationCard(controller),
                      _buildSectionHeader(icon: Icons.location_on, title: 'location_details'.tr),
                      const SizedBox(height: 20),
                      _buildCityDropdown(controller),
                      const SizedBox(height: 16),
                      _buildMapButton(controller),
                      if (controller.latitude != null && controller.longitude != null)
                        _buildLocationSuccessMessage(),
                      const SizedBox(height: 24),
                      _buildSectionHeader(icon: Icons.home, title: 'address_details'.tr),
                      const SizedBox(height: 16),
                      CustomTextFormField(hint: 'enter_area'.tr, label: 'area_district'.tr, prefixIcon: Icons.location_city, controller: controller.areaController, obs: false, color: buttonColor),
                      CustomTextFormField(hint: 'enter_floor'.tr, label: 'floor'.tr, prefixIcon: Icons.layers, controller: controller.floorController, obs: false, color: buttonColor, type: TextInputType.number),
                      CustomTextFormField(hint: 'enter_apartment'.tr, label: 'apartment_number'.tr, prefixIcon: Icons.door_front_door, controller: controller.apartmentController, obs: false, color: buttonColor, type: TextInputType.number),
                      const SizedBox(height: 24),
                      _buildSectionHeader(icon: Icons.contact_phone, title: 'contact_notes'.tr),
                      const SizedBox(height: 16),
                      CustomTextFormField.phone(hint: 'enter_phone'.tr, label: 'phone'.tr, controller: controller.phoneController, color: buttonColor),
                      CustomTextFormField(hint: 'enter_notes'.tr, label: 'additional_notes'.tr, prefixIcon: Icons.note, controller: controller.notesController, obs: false, color: buttonColor, max: 3),
                      const SizedBox(height: 32),
                      Center(
                        child: controller.isLoading
                            ? CircularProgressIndicator(color: buttonColor)
                            : CustomButton(text: 'save_location'.tr.toUpperCase(), width: double.infinity, onPressed: () async {
                                final success = await controller.saveLocation();
                                if (success) Get.back();
                              }),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          ),
          // Floating YAMAA Button
          _FloatingYamaaButton(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader({required IconData icon, required String title}) {
    return Row(children: [Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: (buttonColor as Color).withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: buttonColor, size: 20)), const SizedBox(width: 12), Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: txtColor))]);
  }

  Widget _buildCityDropdown(LocationController controller) {
    return Container(margin: const EdgeInsets.symmetric(horizontal: 16), 
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), 
    border: Border.all(color: Colors.grey.shade300),
     boxShadow: [BoxShadow
     (color: Colors.black.withOpacity(0.05), 
     blurRadius: 8, offset: const Offset(0, 2))]), 
     child: DropdownButtonHideUnderline
     (child: DropdownButton<String>
     (isExpanded: true, hint: 
     Row(children: [Icon(Icons.location_city, 
     color: buttonColor, size: 20), const SizedBox(width: 12),
      Text('select_city'.tr,
       style: TextStyle(color: Colors.grey.shade600, fontSize: 14))]), value: controller.selectedCity, icon: Icon(Icons.arrow_drop_down, color: buttonColor), items: controller.citiesKeys.map((String cityKey) {return DropdownMenuItem<String>(value: cityKey, child: Row(children: [Icon(Icons.location_on, color: iconColor, size: 18), const SizedBox(width: 12), Text(cityKey.tr, style: TextStyle(fontSize: 14, color: txtColor, fontWeight: FontWeight.w500))]));}).toList(), onChanged: (String? value) {controller.selectCity(value);})));
  }

  Widget _buildMapButton(LocationController controller) {
    return Container(margin: const EdgeInsets.symmetric(horizontal: 16), child: ElevatedButton(onPressed: () => Get.to(() => const MapView(), transition: Transition.rightToLeft, duration: const Duration(milliseconds: 400)), style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: buttonColor, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: (buttonColor as Color).withOpacity(0.3))), elevation: 0), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.map_rounded, size: 22), const SizedBox(width: 12), Text('open_map_get_location'.tr, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600))])));
  }

  Widget _buildExistingLocationCard(LocationController controller) {
    return Container(margin: const EdgeInsets.only(bottom: 20), padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [(buttonColor as Color).withOpacity(0.1), (buttonColor as Color).withOpacity(0.05)], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(16), border: Border.all(color: (buttonColor as Color).withOpacity(0.3))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: buttonColor, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.bookmark, color: Colors.white, size: 18)), const SizedBox(width: 12), Expanded(child: Text('previous_location'.tr, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: txtColor))), Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.green.shade200)), child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.check_circle, color: Colors.green.shade700, size: 14), const SizedBox(width: 4), Text('saved'.tr, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.green.shade700))]))]), const SizedBox(height: 16), _buildLocationInfoRow(Icons.location_city, 'city'.tr, controller.selectedCity?.tr ?? 'unknown'.tr), const SizedBox(height: 8), _buildLocationInfoRow(Icons.place, 'area'.tr, controller.areaController.text.isNotEmpty ? controller.areaController.text : 'not_set'.tr), const SizedBox(height: 12), Divider(color: Colors.grey.shade300), const SizedBox(height: 8), Text('update_location_below'.tr, style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontStyle: FontStyle.italic))]));
  }

  Widget _buildLocationInfoRow(IconData icon, String label, String value) {
    return Row(children: [Icon(icon, size: 16, color: Colors.grey.shade600), const SizedBox(width: 8), Text('$label: ', style: TextStyle(fontSize: 13, color: Colors.grey.shade600, fontWeight: FontWeight.w500)), Expanded(child: Text(value, style: TextStyle(fontSize: 13, color: txtColor, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis))]);
  }

  Widget _buildLocationSuccessMessage() {
    return Container(margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.green.shade200)), child: Row(children: [Icon(Icons.check_circle_rounded, color: Colors.green.shade700, size: 24), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('location_detected_successfully'.tr, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.green.shade800)), const SizedBox(height: 4), Text('location_saved_in_background'.tr, style: TextStyle(fontSize: 12, color: Colors.green.shade700))]))]));
  }
}

// Floating YAMAA Button Widget
class _FloatingYamaaButton extends StatelessWidget {
  const _FloatingYamaaButton();

  @override
  Widget build(BuildContext context) {
    final Color resolvedButtonColor =
        buttonColor is Color ? buttonColor as Color : const Color(0xFFE47B39);
    final bool isArabic = Get.locale?.languageCode == 'ar';
    
    return Positioned(
      bottom: 30,
      left: isArabic ? 20 : null,
      right: isArabic ? null : 20,
      child: InkWell(
        onTap: () {
          Get.offAll(() => const AppBottomBar());
        },
        borderRadius: BorderRadius.circular(35),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          height: 65,
          width: 65,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: resolvedButtonColor.withOpacity(0.4),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(
              color: resolvedButtonColor.withOpacity(0.6),
              width: 3,
            ),
          ),
          child: ClipOval(
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Image.asset(
                'assets/images/yamaLogo1.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
