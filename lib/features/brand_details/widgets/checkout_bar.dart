

 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shop_app/features/brand_details/widgets/tabs_bar_widget.dart';

import '../../../core/models/brand.dart';
import '../../checkout/checkout_controller.dart';
import '../../checkout/checkout_view.dart';
import '../../location/service/location_navigator.dart';
import '../controllers/brand_details_controller.dart';
import '../controllers/save_order_controller.dart';

class CheckoutBar extends StatelessWidget {
	const CheckoutBar({
		required this.accentColor,
		required this.controller,
		required this.tabController,
		required this.brand,
	});

	final Color accentColor;
	final BrandDetailsController controller;
	final TabsBarController tabController;
	final Brand brand;

	@override
	Widget build(BuildContext context) {
		final isServicesTab = tabController.selectedTab.value == 0;
		final hasSelection = isServicesTab
			? controller.selectedServicesCount > 0
			: controller.selectedPackagesCount > 0;
		final totalPrice = isServicesTab
			? controller.totalSelectedPrice
			: controller.totalSelectedPackagePrice;
		final selectedCount = isServicesTab
			? controller.selectedServicesCount
			: controller.selectedPackagesCount;
		final selectionType = isServicesTab ? 'services'.tr : 'packages'.tr;

		return GetBuilder<SaveOrderController>(
			builder: (orderController) {
				return Container(
					padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
					decoration: BoxDecoration(
						color: Colors.white,
						boxShadow: [
							BoxShadow(
								color: Colors.black.withOpacity(0.05),
								blurRadius: 16,
								offset: const Offset(0, -6),
							),
						],
					),
					child: Column(
						mainAxisSize: MainAxisSize.min,
						children: [
							// Selected services/packages info
							if (hasSelection) ...[
								Container(
									padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
									decoration: BoxDecoration(
										color: accentColor.withOpacity(0.1),
										borderRadius: BorderRadius.circular(12),
										border: Border.all(color: accentColor.withOpacity(0.3)),
									),
									child: Row(
										children: [
											Icon(Icons.check_circle, color: accentColor, size: 20),
											const SizedBox(width: 8),
											Expanded(
												child: Text(
													'${'selected'.tr}: $selectedCount ${selectionType.toLowerCase()}',
													style: TextStyle(
														color: accentColor,
														fontWeight: FontWeight.w600,
														fontSize: 14,
													),
												),
											),
											Text(
												'BD${totalPrice.toStringAsFixed(2)}',
												style: TextStyle(
													color: accentColor,
													fontWeight: FontWeight.w700,
													fontSize: 16,
												),
											),
										],
									),
								),
								const SizedBox(height: 12),
							],
							// Checkout button
							SizedBox(
								width: double.infinity,
								child: ElevatedButton(
									onPressed: hasSelection && !orderController.isLoading
										? () async {
											// Capture variables before async
											final orderType = isServicesTab ? 'SERVICE' : 'PACKAGE';
											final selectedServicesList = controller.selectedServices;
											final selectedPackagesList = controller.selectedPackages;
											final price = totalPrice;
											final isServTab = isServicesTab;

											// Navigate to location screen first
											final hasLocation = await LocationNavigator.hasLocationSaved();

											if (!hasLocation) {
												// No location, go to location screen
												await LocationNavigator.navigateToLocationScreen();
												// After returning, check again
												final locationAdded = await LocationNavigator.hasLocationSaved();
												if (!locationAdded) {
													// User didn't add location, don't proceed
													return;
												}
											}

											// Initialize checkout controller
											final checkoutController = Get.put(CheckoutController());
                                checkoutController.initializeCheckout(
                                  type: orderType,
                                  orderItems: selectedServicesList.isNotEmpty
                                      ? selectedServicesList
                                      : selectedPackagesList,
                                  price: price,
                                  brand: brand.name,
                                  email: 'info@${brand.name.toLowerCase().replaceAll(' ', '')}.com',
                                  image: brand.image,
                                );											// Navigate to checkout
											final result = await Get.to(() => const CheckoutView());

											// If order placed successfully, clear selections
											if (result == true) {
												if (isServTab) {
													controller.clearSelectedServices();
												} else {
													controller.clearSelectedPackages();
												}
											}
										}
										: null,
									style: ElevatedButton.styleFrom(
										backgroundColor: hasSelection && !orderController.isLoading
											? accentColor
											: Colors.grey.shade300,
										padding: const EdgeInsets.symmetric(vertical: 16),
										shape: RoundedRectangleBorder(
											borderRadius: BorderRadius.circular(16),
										),
									),
									child: orderController.isLoading
										? const SizedBox(
											height: 20,
											width: 20,
											child: CircularProgressIndicator(
												color: Colors.white,
												strokeWidth: 2,
											),
										)
										: Text(
											hasSelection
												? 'checkout'.tr.toUpperCase()
												: (isServicesTab ? 'select_services'.tr : 'select_package'.tr).toUpperCase(),
											style: TextStyle(
												color: hasSelection && !orderController.isLoading
													? Colors.white
													: Colors.grey.shade600,
												fontSize: 16,
												fontWeight: FontWeight.w700,
												letterSpacing: 0.6,
											),
										),
								),
							),
						],
					),
				);
			}
		);
	}
}