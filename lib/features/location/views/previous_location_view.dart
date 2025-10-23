import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/core/widgets/Custom_button.dart';
import 'package:shop_app/core/widgets/custom_appbar.dart';
import 'package:shop_app/features/location/controllers/previous_location_controller.dart';
import 'package:shop_app/features/location/views/location_view.dart';
import 'package:shop_app/features/main_nav_bar/main_nav_bar.dart';

class PreviousLocationView extends StatefulWidget {
  const PreviousLocationView({super.key});

  @override
  State<PreviousLocationView> createState() => _PreviousLocationViewState();
}

class _PreviousLocationViewState extends State<PreviousLocationView> {
  @override
  void initState() {
    super.initState();
    Get.put(PreviousLocationController());
  }

  @override
  void dispose() {
    if (Get.isRegistered<PreviousLocationController>()) {
      Get.delete<PreviousLocationController>();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar('your_saved_location'.tr, true),
      body: Stack(
        children: [
          GetBuilder<PreviousLocationController>(
            builder: (controller) {
              if (controller.isLoading) {
                return Center(child: CircularProgressIndicator(color: buttonColor));
              }

              if (controller.locationData == null) {
                return _buildEmptyState();
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLocationCard(controller),
                      const SizedBox(height: 24),
                      _buildLocationDetails(controller),
                      const SizedBox(height: 32),
                      _buildActionButtons(controller),
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

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 40, 40, 120),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_off, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 20),
            Text(
              'no_saved_location_found'.tr,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: txtColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'add_location_to_get_started'.tr,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: 'add_new_location'.tr.toUpperCase(),
              width: double.infinity,
              onPressed: () {
                Get.off(() => const LocationView());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCard(PreviousLocationController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            (buttonColor as Color).withOpacity(0.15),
            (buttonColor as Color).withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: (buttonColor as Color).withOpacity(0.3), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.location_on, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'saved_location'.tr,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      controller.locationData!['city'] ?? 'unknown'.tr,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: txtColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, color: Colors.green.shade700, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      'active'.tr,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Divider(color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.home, size: 18, color: Colors.grey.shade600),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  controller.getFullAddress(),
                  style: TextStyle(
                    fontSize: 14,
                    color: txtColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationDetails(PreviousLocationController controller) {
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
          Text(
            'location_details'.tr,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: txtColor,
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailRow(Icons.location_city, 'city'.tr, controller.locationData!['city'] ?? 'not_set'.tr),
          const SizedBox(height: 12),
          _buildDetailRow(Icons.place, 'area'.tr, controller.locationData!['area'] ?? 'not_set'.tr),
          if (controller.locationData!['floor'] != null && controller.locationData!['floor'].toString().isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildDetailRow(Icons.layers, 'floor'.tr, controller.locationData!['floor'].toString()),
          ],
          if (controller.locationData!['apartment'] != null && controller.locationData!['apartment'].toString().isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildDetailRow(Icons.door_front_door, 'apartment'.tr, controller.locationData!['apartment'].toString()),
          ],
          if (controller.locationData!['phone'] != null && controller.locationData!['phone'].toString().isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildDetailRow(Icons.phone, 'phone'.tr, controller.locationData!['phone'].toString()),
          ],
          if (controller.locationData!['notes'] != null && controller.locationData!['notes'].toString().isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildDetailRow(Icons.note, 'notes'.tr, controller.locationData!['notes'].toString()),
          ],
          const SizedBox(height: 16),
          Divider(color: Colors.grey.shade300),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.my_location, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  controller.getCoordinates(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey.shade600),
        const SizedBox(width: 12),
        SizedBox(
          width: 100,
          child: Text(
            '$label:',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: txtColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(PreviousLocationController controller) {
    return Column(
      children: [
        CustomButton(
          text: 'another_location'.tr.toUpperCase(),
          width: double.infinity,
          onPressed: () {
            Get.off(() => const LocationView());
          },
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: controller.isDeleting
                ? null
                : () {
                    _showDeleteConfirmation(controller);
                  },
            icon: controller.isDeleting
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.delete_outline),
            label: Text(
              controller.isDeleting ? 'deleting'.tr.toUpperCase() : 'delete_location'.tr.toUpperCase(),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              side: const BorderSide(color: Colors.red, width: 2),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmation(PreviousLocationController controller) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.orange.shade700, size: 28),
            const SizedBox(width: 12),
            Text('confirm_delete'.tr, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: txtColor)),
          ],
        ),
        content: Text(
          'delete_location_confirmation'.tr,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('cancel'.tr, style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w600)),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              controller.deleteLocation();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text('delete'.tr, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
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
