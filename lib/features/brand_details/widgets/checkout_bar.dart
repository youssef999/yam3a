

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
		final actualTotalPrice = isServicesTab
			? controller.totalSelectedPrice
			: controller.totalSelectedPackagePrice;
		final finalTotalPrice = controller.getOrderMinTotal(actualTotalPrice);
		final selectedCount = isServicesTab
			? controller.selectedServicesCount
			: controller.selectedPackagesCount;
		final selectionType = isServicesTab ? 'services'.tr : 'packages'.tr;
		final hasMinimumOrderAdjustment = finalTotalPrice > actualTotalPrice;

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
									padding: const EdgeInsets.all(16),
									decoration: BoxDecoration(
										gradient: LinearGradient(
											colors: [
												accentColor.withOpacity(0.15),
												accentColor.withOpacity(0.05),
											],
											begin: Alignment.topLeft,
											end: Alignment.bottomRight,
										),
										borderRadius: BorderRadius.circular(16),
										border: Border.all(color: accentColor.withOpacity(0.3), width: 1.5),
										boxShadow: [
											BoxShadow(
												color: accentColor.withOpacity(0.1),
												blurRadius: 8,
												offset: const Offset(0, 2),
											),
										],
									),
									child: Column(
										children: [
											// Selection Summary
											Row(
												children: [
													Container(
														padding: const EdgeInsets.all(8),
														decoration: BoxDecoration(
															color: accentColor,
															borderRadius: BorderRadius.circular(8),
														),
														child: Icon(Icons.check_circle, color: Colors.white, size: 20),
													),
													const SizedBox(width: 12),
													Expanded(
														child: Column(
															crossAxisAlignment: CrossAxisAlignment.start,
															children: [
																Text(
																	'$selectedCount ${selectionType.toLowerCase()} ${'selected'.tr}',
																	style: TextStyle(
																		color: accentColor,
																		fontWeight: FontWeight.w700,
																		fontSize: 15,
																	),
																),
																Text(
																	'order_total'.tr,
																	style: TextStyle(
																		color: Colors.grey[600],
																		fontSize: 12,
																	),
																),
															],
														),
													),
													Container(
														padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
														decoration: BoxDecoration(
															color: Colors.white,
															borderRadius: BorderRadius.circular(8),
															border: Border.all(color: accentColor.withOpacity(0.3)),
														),
														child: Text(
															'BD${actualTotalPrice.toStringAsFixed(2)}',
															style: TextStyle(
																color: accentColor,
																fontWeight: FontWeight.w800,
																fontSize: 16,
															),
														),
													),
												],
											),
											
											// Payment Amount Section
											const SizedBox(height: 16),
											Container(
												padding: const EdgeInsets.all(14),
												decoration: BoxDecoration(
													color: Colors.white,
													borderRadius: BorderRadius.circular(12),
													border: Border.all(
														color: hasMinimumOrderAdjustment 
															? Colors.orange.withOpacity(0.4)
															: Colors.green.withOpacity(0.4), 
														width: 1.5
													),
												),
												child: Column(
													children: [
														Row(
															children: [
																Icon(
																	hasMinimumOrderAdjustment 
																		? Icons.info_outline 
																		: Icons.payment,
																	color: hasMinimumOrderAdjustment 
																		? Colors.orange[600] 
																		: Colors.green[600],
																	size: 20,
																),
																const SizedBox(width: 8),
																Expanded(
																	child: Text(
																		hasMinimumOrderAdjustment 
																			? 'minimum_order_applied'.tr
																			: 'amount_to_pay'.tr,
																		style: TextStyle(
																			color: hasMinimumOrderAdjustment 
																				? Colors.orange[800] 
																				: Colors.green[800],
																			fontWeight: FontWeight.w600,
																			fontSize: 14,
																		),
																	),
																),
															],
														),
														const SizedBox(height: 8),
														Row(
															mainAxisAlignment: MainAxisAlignment.spaceBetween,
															children: [
																Text(
																	'you_will_pay'.tr,
																	style: TextStyle(
																		color: Colors.grey[700],
																		fontSize: 16,
																		fontWeight: FontWeight.w600,
																	),
																),
																Container(
																	padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
																	decoration: BoxDecoration(
																		gradient: LinearGradient(
																			colors: hasMinimumOrderAdjustment 
																				? [Colors.orange[400]!, Colors.orange[600]!]
																				: [Colors.green[400]!, Colors.green[600]!],
																		),
																		borderRadius: BorderRadius.circular(20),
																		boxShadow: [
																			BoxShadow(
																				color: (hasMinimumOrderAdjustment 
																					? Colors.orange 
																					: Colors.green).withOpacity(0.3),
																				blurRadius: 6,
																				offset: const Offset(0, 2),
																			),
																		],
																	),
																	child: Text(
																		'BD ${finalTotalPrice.toStringAsFixed(2)}',
																		style: const TextStyle(
																			color: Colors.white,
																			fontSize: 18,
																			fontWeight: FontWeight.w900,
																		),
																	),
																),
															],
														),
														
														// Show minimum order explanation if applicable
														if (hasMinimumOrderAdjustment) ...[
															const SizedBox(height: 12),
															Container(
																padding: const EdgeInsets.all(10),
																decoration: BoxDecoration(
																	color: Colors.orange[50],
																	borderRadius: BorderRadius.circular(8),
																	border: Border.all(color: Colors.orange[200]!),
																),
																child: Row(
																	children: [
																		Icon(Icons.lightbulb_outline, 
																			color: Colors.orange[600], size: 16),
																		const SizedBox(width: 8),
																		Expanded(
																			child: RichText(
																				text: TextSpan(
																					style: TextStyle(
																						color: Colors.orange[800],
																						fontSize: 12,
																					),
																					children: [
																						TextSpan(text: 'minimum_order_explanation'.tr),
																						TextSpan(
																							text: ' BD${controller.minValueForOrderPercetage.toStringAsFixed(2)}',
																							style: const TextStyle(fontWeight: FontWeight.w700),
																						),
																					],
																				),
																			),
																		),
																	],
																),
															),
														],
													],
												),
											),
										],
									),
								),
								const SizedBox(height: 16),
							],
							// Selected Receive Date Display
							if (hasSelection && controller.selectedReceiveDate != null) ...[
								Container(
									width: double.infinity,
									padding: const EdgeInsets.all(12),
									margin: const EdgeInsets.only(bottom: 12),
									decoration: BoxDecoration(
										color: Colors.blue[50],
										borderRadius: BorderRadius.circular(12),
										border: Border.all(color: Colors.blue[200]!),
									),
									child: Row(
										children: [
											Icon(Icons.calendar_today, color: Colors.blue[700], size: 18),
											const SizedBox(width: 8),
											Text(
												'${'receive_date'.tr}: ',
												style: TextStyle(
													color: Colors.blue[700],
													fontSize: 14,
													fontWeight: FontWeight.w600,
												),
											),
											Text(
												controller.formattedReceiveDate,
												style: TextStyle(
													color: Colors.blue[800],
													fontSize: 14,
													fontWeight: FontWeight.bold,
												),
											),
										],
									),
								),
							],

							// Quick Summary
							if (hasSelection) ...[
								Padding(
									padding: const EdgeInsets.symmetric(horizontal: 4),
									child: Row(
										mainAxisAlignment: MainAxisAlignment.center,
										children: [
											Icon(
												Icons.security,
												size: 16,
												color: Colors.grey[600],
											),
											const SizedBox(width: 6),
											Expanded(
												child: Text(
													'secure_payment_process'.tr,
													textAlign: TextAlign.center,
													style: TextStyle(
														color: Colors.grey[600],
														fontSize: 12,
														fontWeight: FontWeight.w500,
													),
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
											// First show date picker dialog
											final dateSelected = await controller.selectReceiveDate();
											if (!dateSelected) {
												// User cancelled date selection, don't proceed
												return;
											}

											// Capture variables before async
											final orderType = isServicesTab ? 'SERVICE' : 'PACKAGE';
											final selectedServicesList = controller.selectedServices;
											final selectedPackagesList = controller.selectedPackages;
											final actualPrice = actualTotalPrice; // Original order total
											final paidPrice = finalTotalPrice; // Amount to be paid (with minimum order)
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
                                  price: paidPrice,
                                  actualOrderTotal: actualPrice,
                                  brand: brand.name,
                                  email: 'info@${brand.name.toLowerCase().replaceAll(' ', '')}.com',
                                  image: brand.image,
                                  selectedReceiveDate: controller.selectedReceiveDate,
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
										: Column(
											mainAxisSize: MainAxisSize.min,
											children: [
												Text(
													hasSelection
														? 'proceed_to_checkout'.tr.toUpperCase()
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
												if (hasSelection) ...[
													const SizedBox(height: 4),
													Text(
														'BD ${finalTotalPrice.toStringAsFixed(2)}',
														style: const TextStyle(
															color: Colors.white,
															fontSize: 14,
															fontWeight: FontWeight.w600,
														),
													),
												],
											],
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