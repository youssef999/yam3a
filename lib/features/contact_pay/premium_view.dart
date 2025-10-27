import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/core/widgets/custom_appbar.dart';
import 'package:shop_app/core/widgets/Custom_button.dart';
import 'package:shop_app/features/contact_pay/contact_pay_controller.dart';

class PremiumView extends StatefulWidget {
  const PremiumView({super.key});

  @override
  State<PremiumView> createState() => _PremiumViewState();
}

class _PremiumViewState extends State<PremiumView> {
  @override
  void initState() {
    super.initState();
    Get.put(ContactPayController());
  }

  @override
  void dispose() {
    if (Get.isRegistered<ContactPayController>()) {
      Get.delete<ContactPayController>();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar('premium_mode'.tr, true),
      body: GetBuilder<ContactPayController>(
        builder: (controller) {
          return RefreshIndicator(
            color: buttonColor,
            onRefresh: controller.refreshPremiumPrice,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Premium Header Card
                  _buildPremiumHeaderCard(controller),
                  
                  const SizedBox(height: 24),
                  
                  // Price Display Card
                  _buildPriceCard(controller),
                  
                  const SizedBox(height: 34),
                  
                  // Features Section
                 // _buildFeaturesSection(),
                  
        
                  
                  // Action Buttons
                  _buildActionButtons(controller),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPremiumHeaderCard(ContactPayController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.workspace_premium,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'yamaa_premium'.tr,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'unlock_premium_experience'.tr,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'premium_description'.tr,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white.withOpacity(0.9),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceCard(ContactPayController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          if (controller.isLoadingPrice)
            _buildLoadingState()
          else if (controller.errorMessage != null)
            _buildErrorState(controller)
          else
            _buildPriceDisplay(controller),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Column(
      children: [
        CircularProgressIndicator(color: buttonColor),
        const SizedBox(height: 16),
        Text(
          'loading_premium_price'.tr,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(ContactPayController controller) {
    return Column(
      children: [
        Icon(
          Icons.error_outline,
          size: 48,
          color: Colors.red[400],
        ),
        const SizedBox(height: 16),
        Text(
          controller.errorMessage ?? 'failed_to_load_price'.tr,
          style: TextStyle(
            fontSize: 16,
            color: Colors.red[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        TextButton.icon(
          onPressed: controller.refreshPremiumPrice,
          icon: const Icon(Icons.refresh),
          label: Text('retry'.tr),
          style: TextButton.styleFrom(
            foregroundColor: buttonColor,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceDisplay(ContactPayController controller) {
    return Column(
      children: [
        Text(
          'premium_price'.tr,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'bd_currency'.tr,
              style: TextStyle(
                fontSize: 20,
                color: buttonColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              controller.premiumPrice.toStringAsFixed(2),
              style: TextStyle(
                fontSize: 48,
                color: buttonColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'per_month'.tr,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: buttonColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'best_value_premium'.tr,
            style: TextStyle(
              fontSize: 12,
              color: buttonColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesSection() {
    final features = [
      {
        'icon': Icons.flash_on,
        'title': 'priority_support'.tr,
        'description': 'priority_support_desc'.tr
      },
      {
        'icon': Icons.star,
        'title': 'exclusive_features'.tr,
        'description': 'exclusive_features_desc'.tr
      },
      {
        'icon': Icons.speed,
        'title': 'faster_processing'.tr,
        'description': 'faster_processing_desc'.tr
      },
      {
        'icon': Icons.local_offer,
        'title': 'special_discounts'.tr,
        'description': 'special_discounts_desc'.tr
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'premium_features'.tr,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 16),
        ...features.map((feature) => _buildFeatureItem(
          feature['icon'] as IconData,
          feature['title'] as String,
          feature['description'] as String,
        )),
      ],
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: buttonColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: buttonColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(ContactPayController controller) {
    return Padding(
      padding: const EdgeInsets.only(left:38.0,right: 38),
      child: Column(
        children: [
          CustomButton(
            text: controller.isPriceAvailable 
                ? 'subscribe_for_price'.tr.replaceAll('{price}', controller.monthlyPrice)
                : 'subscribe_to_premium'.tr,
            width: double.infinity,
            onPressed: () {
              if (controller.isPriceAvailable) {
                _handleSubscribe(controller);
              } else {
                controller.refreshPremiumPrice();
              }
            },
          ),
          const SizedBox(height: 12),
          // TextButton(
          //   onPressed: controller.refreshPremiumPrice,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Icon(
          //         Icons.refresh,
          //         size: 18,
          //         color: Colors.grey[600],
          //       ),
          //       const SizedBox(width: 8),
          //       Text(
          //         'refresh_price'.tr,
          //         style: TextStyle(
          //           color: Colors.grey[600],
          //           fontSize: 14,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  void _handleSubscribe(ContactPayController controller) {
    Get.snackbar(
      'premium_subscription'.tr,
      'subscribe_unlock_features'.tr.replaceAll('{price}', controller.monthlyPrice),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: buttonColor,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      icon: const Icon(
        Icons.workspace_premium,
        color: Colors.white,
      ),
    );
  }
}