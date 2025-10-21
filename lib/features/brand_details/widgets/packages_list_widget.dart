import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/models/package.dart';
import 'package:shop_app/features/brand_details/controllers/brand_details_controller.dart';

class PackagesListWidget extends StatelessWidget {
	const PackagesListWidget({
		super.key,
		required this.packages,
		required this.accentColor,
		required this.controller,
	});

	final List<Package> packages;
	final Color accentColor;
	final BrandDetailsController controller;

	@override
	Widget build(BuildContext context) {
		if (packages.isEmpty) {
			return _buildEmptyState();
		}

		return GetBuilder<BrandDetailsController>(
			builder: (ctrl) => ListView.separated(
				shrinkWrap: true,
				physics: const NeverScrollableScrollPhysics(),
				itemCount: packages.length,
				separatorBuilder: (context, index) => const SizedBox(height: 16),
				itemBuilder: (context, index) {
					final package = packages[index];
					return PackageCardWidget(
						package: package,
						controller: controller,
						accentColor: accentColor,
					);
				},
			),
		);
	}

	Widget _buildEmptyState() {
		return Center(
			child: Padding(
				padding: const EdgeInsets.all(40),
				child: Column(
					mainAxisSize: MainAxisSize.min,
					children: [
						Icon(
							Icons.inventory_2_outlined,
							size: 80,
							color: Colors.grey.shade300,
						),
						const SizedBox(height: 16),
						Text(
							'no_packages_available'.tr,
							style: TextStyle(
								fontSize: 18,
								fontWeight: FontWeight.w600,
								color: Colors.grey.shade600,
							),
						),
						const SizedBox(height: 8),
						Text(
							'check_back_later'.tr,
							style: TextStyle(
								fontSize: 14,
								color: Colors.grey.shade500,
							),
							textAlign: TextAlign.center,
						),
					],
				),
			),
		);
	}
}

class PackageCardWidget extends StatefulWidget {
	const PackageCardWidget({
		super.key,
		required this.package,
		required this.controller,
		required this.accentColor,
	});

	final Package package;
	final BrandDetailsController controller;
	final Color accentColor;

	@override
	State<PackageCardWidget> createState() => _PackageCardWidgetState();
}

class _PackageCardWidgetState extends State<PackageCardWidget>
		with SingleTickerProviderStateMixin {
	late AnimationController _animationController;
	bool _showDetails = false;

	@override
	void initState() {
		super.initState();
		_animationController = AnimationController(
			duration: const Duration(milliseconds: 300),
			vsync: this,
		);
	}

	@override
	void dispose() {
		_animationController.dispose();
		super.dispose();
	}

	void _toggleDetails() {
		setState(() {
			_showDetails = !_showDetails;
		});
		if (_showDetails) {
			_animationController.forward();
		} else {
			_animationController.reverse();
		}
	}

	@override
	Widget build(BuildContext context) {
		final isArabic = Get.locale?.languageCode == 'ar';
		final isSelected = widget.controller.isPackageSelected(widget.package);

		return Container(
			decoration: BoxDecoration(
				color: Colors.white,
				borderRadius: BorderRadius.circular(20),
				border: isSelected
						? Border.all(color: widget.accentColor, width: 2)
						: Border.all(color: Colors.grey.shade100),
				boxShadow: [
					BoxShadow(
						color: isSelected
								? widget.accentColor.withOpacity(0.15)
								: Colors.black.withOpacity(0.05),
						blurRadius: isSelected ? 20 : 16,
						offset: const Offset(0, 8),
						spreadRadius: isSelected ? 2 : 0,
					),
				],
			),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					// Main package card content
					Padding(
						padding: const EdgeInsets.all(16),
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								// Header with name, popular badge and checkbox
								Row(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										// Package image
										Container(
											width: 80,
											height: 80,
											decoration: BoxDecoration(
												borderRadius: BorderRadius.circular(12),
												color: Colors.grey.shade100,
												image: widget.package.image.isNotEmpty
														? DecorationImage(
															image: NetworkImage(widget.package.image),
															fit: BoxFit.cover,
														)
														: null,
											),
											child: widget.package.image.isEmpty
													? Icon(
														Icons.card_giftcard,
														color: widget.accentColor.withOpacity(0.5),
														size: 32,
													)
													: null,
										),
										const SizedBox(width: 16),
										// Package info
										Expanded(
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: [
													Row(
														children: [
															Expanded(
																child: Text(
																	isArabic
																			? (widget.package.name.isNotEmpty
																					? widget.package.name
																					: widget.package.nameEn)
																			: (widget.package.nameEn.isNotEmpty
																					? widget.package.nameEn
																					: widget.package.name),
																	style: const TextStyle(
																		fontSize: 16,
																		fontWeight: FontWeight.w700,
																		color: Colors.black87,
																	),
																),
															),
															if (widget.package.isPopular)
																Container(
																	padding: const EdgeInsets.symmetric(
																		horizontal: 8,
																		vertical: 4,
																	),
																	decoration: BoxDecoration(
																		color: Colors.orange,
																		borderRadius: BorderRadius.circular(12),
																	),
																	child: Row(
																		mainAxisSize: MainAxisSize.min,
																		children: [
																			const Icon(
																				Icons.local_fire_department,
																				size: 12,
																				color: Colors.white,
																			),
																			const SizedBox(width: 4),
																			Text(
																				'popular'.tr,
																				style: const TextStyle(
																					color: Colors.white,
																					fontSize: 10,
																					fontWeight: FontWeight.bold,
																				),
																			),
																		],
																	),
																),
														],
													),
													const SizedBox(height: 4),
													Text(
														isArabic
																? (widget.package.description.isNotEmpty
																		? widget.package.description
																		: widget.package.descriptionEn)
																: (widget.package.descriptionEn.isNotEmpty
																		? widget.package.descriptionEn
																		: widget.package.description),
														maxLines: 2,
														overflow: TextOverflow.ellipsis,
														style: const TextStyle(
															fontSize: 13,
															color: Colors.black54,
															height: 1.3,
														),
													),
												],
											),
										),
										// Checkbox
										GestureDetector(
											onTap: () => widget.controller.togglePackageSelection(widget.package),
											child: Container(
												width: 28,
												height: 28,
												decoration: BoxDecoration(
													color: isSelected
															? widget.accentColor
															: Colors.transparent,
													border: Border.all(
														color: isSelected
																? widget.accentColor
																: Colors.grey.shade400,
														width: 2,
													),
													borderRadius: BorderRadius.circular(8),
												),
												child: isSelected
														? const Icon(
															Icons.check,
															color: Colors.white,
															size: 18,
														)
														: null,
											),
										),
									],
								),
								const SizedBox(height: 12),
								// Pricing section
								Row(
									children: [
										// Discounted price
										if (widget.package.hasDiscount) ...[
											Text(
												'BD ${widget.package.discountPrice.toStringAsFixed(2)}',
												style: TextStyle(
													decoration: TextDecoration.lineThrough,
													color: Colors.grey.shade600,
													fontSize: 14,
													fontWeight: FontWeight.w500,
												),
											),
											const SizedBox(width: 8),
										],
										// Current price
										Container(
											padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
											decoration: BoxDecoration(
												color: widget.accentColor.withOpacity(0.1),
												borderRadius: BorderRadius.circular(8),
											),
											child: Text(
												'BD ${widget.package.price.toStringAsFixed(2)}',
												style: TextStyle(
													color: widget.accentColor,
													fontWeight: FontWeight.w700,
													fontSize: 16,
												),
											),
										),
										// Discount percentage
										if (widget.package.hasDiscount) ...[
											const SizedBox(width: 8),
											Container(
												padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
												decoration: BoxDecoration(
													color: Colors.green,
													borderRadius: BorderRadius.circular(6),
												),
												child: Text(
													'-${widget.package.discountPercentage.toStringAsFixed(0)}%',
													style: const TextStyle(
														color: Colors.white,
														fontSize: 12,
														fontWeight: FontWeight.bold,
													),
												),
											),
										],
										const Spacer(),
										// Save amount
										if (widget.package.hasDiscount)
											Text(
												'${'save'.tr} BD ${(widget.package.discountPrice - widget.package.price).toStringAsFixed(2)}',
												style: TextStyle(
													color: Colors.green.shade700,
													fontSize: 12,
													fontWeight: FontWeight.w600,
												),
											),
									],
								),
								const SizedBox(height: 12),
								// Package details chips
								Wrap(
									spacing: 8,
									runSpacing: 8,
									children: [
										_buildDetailChip(
											Icons.schedule,
											'${widget.package.minDays} ${'days'.tr}',
											Colors.blue,
										),
										_buildDetailChip(
											Icons.access_time,
											'${'valid_for'.tr} ${widget.package.validityDays} ${'days'.tr}',
											Colors.green,
										),
										_buildDetailChip(
											Icons.category_outlined,
											isArabic
													? widget.package.category
													: widget.package.categoryEn,
											Colors.orange,
										),
										if (widget.package.includedServices.isNotEmpty)
											_buildDetailChip(
												Icons.check_circle_outline,
												'${widget.package.includedServices.length} ${'services_included'.tr}',
												Colors.purple,
											),
									],
								),
							],
						),
					),
					// Expandable details section
					AnimatedContainer(
						duration: const Duration(milliseconds: 300),
						curve: Curves.easeInOut,
						height: _showDetails ? null : 0,
						child: _showDetails
								? Container(
									padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
									decoration: BoxDecoration(
										color: Colors.grey.shade50,
										borderRadius: const BorderRadius.only(
											bottomLeft: Radius.circular(20),
											bottomRight: Radius.circular(20),
										),
									),
									child: Column(
										crossAxisAlignment: CrossAxisAlignment.start,
										children: [
											const Divider(height: 1),
											const SizedBox(height: 12),
											Text(
												'package_details'.tr,
												style: TextStyle(
													fontSize: 14,
													fontWeight: FontWeight.w600,
													color: widget.accentColor,
												),
											),
											const SizedBox(height: 8),
											Text(
												isArabic
														? widget.package.description
														: widget.package.descriptionEn,
												style: const TextStyle(
													fontSize: 13,
													color: Colors.black87,
													height: 1.4,
												),
											),
											const SizedBox(height: 12),
											// Additional details
											_buildDetailRow(
												Icons.category_outlined,
												'category'.tr,
												isArabic
														? widget.package.category
														: widget.package.categoryEn,
											),
											const SizedBox(height: 8),
											_buildDetailRow(
												Icons.schedule_outlined,
												'preparation'.tr,
												'${widget.package.minDays} ${'days'.tr}',
											),
											const SizedBox(height: 8),
											_buildDetailRow(
												Icons.event_available,
												'validity'.tr,
												'${widget.package.validityDays} ${'days'.tr}',
											),
											if (widget.package.includedServices.isNotEmpty) ...[
												const SizedBox(height: 8),
												_buildDetailRow(
													Icons.check_circle_outline,
													'included_services'.tr,
													'${widget.package.includedServices.length} ${'services'.tr}',
												),
											],
										],
									),
								)
								: const SizedBox.shrink(),
					),
					// Action buttons
					Container(
						padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
						decoration: BoxDecoration(
							border: Border(
								top: BorderSide(color: Colors.grey.shade100),
							),
						),
						child: Row(
							children: [
								TextButton.icon(
									onPressed: _toggleDetails,
									icon: AnimatedRotation(
										turns: _showDetails ? 0.5 : 0,
										duration: const Duration(milliseconds: 300),
										child: Icon(
											Icons.keyboard_arrow_down,
											size: 18,
											color: widget.accentColor,
										),
									),
									label: Text(
										_showDetails ? 'hide_details'.tr : 'view_details'.tr,
										style: TextStyle(
											color: widget.accentColor,
											fontWeight: FontWeight.w600,
										),
									),
									style: TextButton.styleFrom(
										padding: const EdgeInsets.symmetric(horizontal: 8),
									),
								),
								const Spacer(),
								TextButton.icon(
									onPressed: () {
										widget.controller.togglePackageSelection(widget.package);
									},
									icon: Icon(
										isSelected ? Icons.check_circle : Icons.add_circle_outline,
										size: 18,
									),
									label: Text(isSelected ? 'selected'.tr : 'select_package'.tr),
									style: TextButton.styleFrom(
										foregroundColor: widget.accentColor,
										backgroundColor: widget.accentColor.withOpacity(0.1),
										padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
										shape: RoundedRectangleBorder(
											borderRadius: BorderRadius.circular(12),
										),
									),
								),
							],
						),
					),
				],
			),
		);
	}

	Widget _buildDetailChip(IconData icon, String label, Color color) {
		return Container(
			padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
			decoration: BoxDecoration(
				color: color.withOpacity(0.1),
				borderRadius: BorderRadius.circular(12),
				border: Border.all(color: color.withOpacity(0.3)),
			),
			child: Row(
				mainAxisSize: MainAxisSize.min,
				children: [
					Icon(icon, size: 14, color: color),
					const SizedBox(width: 6),
					Text(
						label,
						style: TextStyle(
							color: color,
							fontSize: 12,
							fontWeight: FontWeight.w600,
						),
					),
				],
			),
		);
	}

	Widget _buildDetailRow(IconData icon, String label, String value) {
		return Row(
			children: [
				Icon(icon, size: 16, color: Colors.grey.shade600),
				const SizedBox(width: 8),
				Text(
					'$label: ',
					style: TextStyle(
						fontSize: 12,
						color: Colors.grey.shade600,
						fontWeight: FontWeight.w500,
					),
				),
				Expanded(
					child: Text(
						value,
						style: const TextStyle(
							fontSize: 12,
							color: Colors.black87,
							fontWeight: FontWeight.w600,
						),
					),
				),
			],
		);
	}
}