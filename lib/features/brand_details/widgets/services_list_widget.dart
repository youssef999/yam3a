import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/models/service.dart';
import 'package:shop_app/features/brand_details/controllers/brand_details_controller.dart';

class ServicesListWidget extends StatelessWidget {
	const ServicesListWidget({
		super.key,
		required this.services,
		required this.accentColor,
    required this.controller,
	});

	final List<Service> services;
	final Color accentColor;
  final BrandDetailsController controller;

	@override
	Widget build(BuildContext context) {
		return GetBuilder<BrandDetailsController>(
      init: BrandDetailsController(brand: controller.brand),
			builder: (ctrl) {
				// Show empty state when no services are available
				if (services.isEmpty) {
					return _EmptyServicesState(accentColor: accentColor);
				}
				
				return ListView.separated(
					shrinkWrap: true,
					physics: const NeverScrollableScrollPhysics(),
					itemCount: services.length,
					separatorBuilder: (context, index) => const SizedBox(height: 16),
					itemBuilder: (context, index) {
						final service = services[index];
						return ServiceCardWidget(
							service: service,
							controller: controller,
							accentColor: accentColor,
						);
					},
				);
			},
		);
	}
}

class ServiceCardWidget extends StatefulWidget {
	const ServiceCardWidget({
		super.key, 
		required this.service, 
		required this.controller,
		required this.accentColor
	});

	final Service service;
	final BrandDetailsController controller;
	final Color accentColor;

	@override
	State<ServiceCardWidget> createState() => _ServiceCardWidgetState();
}

class _ServiceCardWidgetState extends State<ServiceCardWidget> 
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
		return Container(
			decoration: BoxDecoration(
				color: Colors.white,
				borderRadius: BorderRadius.circular(20),
				border: widget.controller.isServiceSelected(widget.service)
					? Border.all(color: widget.accentColor, width: 2)
					: Border.all(color: Colors.grey.shade100),
				boxShadow: [
					BoxShadow(
						color: widget.controller.isServiceSelected(widget.service)
							? widget.accentColor.withOpacity(0.15)
							: Colors.black.withOpacity(0.05),
						blurRadius: widget.controller.isServiceSelected(widget.service) ? 20 : 16,
						offset: const Offset(0, 8),
						spreadRadius: widget.controller.isServiceSelected(widget.service) ? 2 : 0,
					),
				],
			),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					// Main service card content
					Padding(
						padding: const EdgeInsets.all(16),
						child: Row(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								// Service Image
								Container(
									width: 80,
									height: 80,
									decoration: BoxDecoration(
										borderRadius: BorderRadius.circular(12),
										color: Colors.grey.shade100,
										image: widget.service.image.isNotEmpty
											? DecorationImage(
												image: NetworkImage(widget.service.image),
												fit: BoxFit.cover,
											)
											: null,
									),
									child: widget.service.image.isEmpty
										? Icon(
											Icons.home_repair_service,
											color: widget.accentColor.withOpacity(0.5),
											size: 32,
										)
										: null,
								),
								const SizedBox(width: 16),
								// Service Info
								Expanded(
									child: Column(
										crossAxisAlignment: CrossAxisAlignment.start,
										children: [
											Text(
												Get.locale?.languageCode == 'ar' 
													? (widget.service.name.isNotEmpty ? widget.service.name : widget.service.nameEn) 
													: (widget.service.nameEn.isNotEmpty ? widget.service.nameEn : widget.service.name),
												style: const TextStyle(
													fontSize: 16,
													fontWeight: FontWeight.w700,
													color: Colors.black87,
												),
											),
											const SizedBox(height: 4),
											Text(
												Get.locale?.languageCode == 'ar' 
													? (widget.service.description.isNotEmpty ? widget.service.description : widget.service.descriptionEn)
													: (widget.service.descriptionEn.isNotEmpty ? widget.service.descriptionEn : widget.service.description),
												maxLines: 2,
												overflow: TextOverflow.ellipsis,
												style: const TextStyle(
													fontSize: 13,
													color: Colors.black54,
													height: 1.3,
												),
											),
											const SizedBox(height: 8),
											Row(
												children: [
													Container(
														padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
														decoration: BoxDecoration(
															color: widget.accentColor.withOpacity(0.1),
															borderRadius: BorderRadius.circular(8),
														),
														child: Text(
															'BD${widget.service.price.toStringAsFixed(2)}',
															style: TextStyle(
																color: widget.accentColor,
																fontWeight: FontWeight.w700,
																fontSize: 14,
															),
														),
													),
													const SizedBox(width: 8),
													Icon(Icons.timer_outlined, size: 14, color: Colors.grey.shade600),
													const SizedBox(width: 4),
													Text(
														'${widget.service.minDays} ${'days'.tr}',
														style: TextStyle(
															fontSize: 12,
															color: Colors.grey.shade600,
															fontWeight: FontWeight.w500,
														),
													),
												],
											),
										],
									),
								),
								// Checkbox
								GestureDetector(
									onTap: () => widget.controller.toggleServiceSelection(widget.service),
									child: Container(
										width: 28,
										height: 28,
										decoration: BoxDecoration(
											color: widget.controller.isServiceSelected(widget.service)
												? widget.accentColor
												: Colors.transparent,
											border: Border.all(
												color: widget.controller.isServiceSelected(widget.service)
													? widget.accentColor
													: Colors.grey.shade400,
												width: 2,
											),
											borderRadius: BorderRadius.circular(8),
										),
										child: widget.controller.isServiceSelected(widget.service)
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
					),
					// Details section with animation
					AnimatedContainer(
						duration: const Duration(milliseconds: 300),
						curve: Curves.easeInOut,
						height: _showDetails ? null : 0,
						child: _showDetails ? Container(
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
										'service_details'.tr,
										style: TextStyle(
											fontSize: 14,
											fontWeight: FontWeight.w600,
											color: widget.accentColor,
										),
									),
									const SizedBox(height: 8),
									Text(
										Get.locale?.languageCode == 'ar' 
											? (widget.service.description.isNotEmpty ? widget.service.description : widget.service.descriptionEn)
											: (widget.service.descriptionEn.isNotEmpty ? widget.service.descriptionEn : widget.service.description),
										style: const TextStyle(
											fontSize: 13,
											color: Colors.black87,
											height: 1.4,
										),
									),
									const SizedBox(height: 12),
									Row(
										children: [
											_buildDetailItem(
												Icons.category_outlined,
												'category'.tr,
												Get.locale?.languageCode == 'ar' 
													? widget.service.category 
													: widget.service.categoryEn,
											),
											const SizedBox(width: 16),
											_buildDetailItem(
												Icons.schedule_outlined,
												'preparation'.tr,
												'${widget.service.minDays} ${'days'.tr}',
											),
										],
									),
								],
							),
						) : const SizedBox.shrink(),
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
										// Handle book now action
									},
									icon: const Icon(Icons.book_online_outlined, size: 18),
									label: Text('book_now'.tr),
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

	Widget _buildDetailItem(IconData icon, String label, String value) {
		return Expanded(
			child: Row(
				children: [
					Icon(icon, size: 16, color: Colors.grey.shade600),
					const SizedBox(width: 6),
					Expanded(
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								Text(
									label,
									style: TextStyle(
										fontSize: 11,
										color: Colors.grey.shade600,
										fontWeight: FontWeight.w500,
									),
								),
								Text(
									value.isNotEmpty ? value : 'N/A',
									style: const TextStyle(
										fontSize: 12,
										color: Colors.black87,
										fontWeight: FontWeight.w600,
									),
								),
							],
						),
					),
				],
			),
		);
	}
}

// Empty Services State Widget
class _EmptyServicesState extends StatelessWidget {
	const _EmptyServicesState({required this.accentColor});

	final Color accentColor;

	@override
	Widget build(BuildContext context) {
		return Container(
			padding: const EdgeInsets.all(32),
			margin: const EdgeInsets.symmetric(vertical: 20),
			decoration: BoxDecoration(
				color: Colors.white,
				borderRadius: BorderRadius.circular(24),
				boxShadow: [
					BoxShadow(
						color: Colors.black.withOpacity(0.05),
						blurRadius: 20,
						offset: const Offset(0, 8),
					),
				],
			),
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					// Animated Icon Container
					Container(
						padding: const EdgeInsets.all(24),
						decoration: BoxDecoration(
							color: accentColor.withOpacity(0.1),
							shape: BoxShape.circle,
						),
						child: Container(
							padding: const EdgeInsets.all(16),
							decoration: BoxDecoration(
								color: accentColor.withOpacity(0.15),
								shape: BoxShape.circle,
							),
							child: Icon(
								Icons.home_repair_service_outlined,
								size: 48,
								color: accentColor.withOpacity(0.7),
							),
						),
					),
					const SizedBox(height: 24),
					
					// Title
					Text(
            'no_services_found'.tr,
						// 'no_services_available'.tr.isNotEmpty 
						// 	? 'no_services_available'.tr 
						// 	: 'No Services Available',
						style: TextStyle(
							fontSize: 20,
							fontWeight: FontWeight.w700,
							color: Colors.grey.shade800,
						),
						textAlign: TextAlign.center,
					),
					const SizedBox(height: 12),
					
					// Description
					// Text(
					// 	'no_services_description'.tr.isNotEmpty 
					// 		? 'no_services_description'.tr 
					// 		: 'This brand currently doesn\'t have any services available. Please check back later or explore other brands.',
					// 	style: TextStyle(
					// 		fontSize: 15,
					// 		color: Colors.grey.shade600,
					// 		height: 1.5,
					// 	),
					// 	textAlign: TextAlign.center,
					// ),
					const SizedBox(height: 24),
					
					// Suggestions Card
					// Container(
					// 	padding: const EdgeInsets.all(16),
					// 	decoration: BoxDecoration(
					// 		color: accentColor.withOpacity(0.05),
					// 		borderRadius: BorderRadius.circular(16),
					// 		border: Border.all(
					// 			color: accentColor.withOpacity(0.2),
					// 			width: 1,
					// 		),
					// 	),
					// 	child: Column(
					// 		children: [
					// 			Row(
					// 				children: [
					// 					Icon(
					// 						Icons.lightbulb_outline,
					// 						color: accentColor,
					// 						size: 20,
					// 					),
					// 					const SizedBox(width: 8),
					// 					Text(
					// 						'suggestions'.tr.isNotEmpty 
					// 							? 'suggestions'.tr 
					// 							: 'Suggestions',
					// 						style: TextStyle(
					// 							fontSize: 16,
					// 							fontWeight: FontWeight.w600,
					// 							color: accentColor,
					// 						),
					// 					),
					// 				],
					// 			),
					// 			const SizedBox(height: 12),
					// 			_buildSuggestionItem(
					// 				Icons.refresh_rounded,
					// 				'refresh_services'.tr.isNotEmpty 
					// 					? 'refresh_services'.tr 
					// 					: 'Try refreshing the page',
					// 			),
					// 			const SizedBox(height: 8),
					// 			_buildSuggestionItem(
					// 				Icons.search_rounded,
					// 				'explore_other_brands'.tr.isNotEmpty 
					// 					? 'explore_other_brands'.tr 
					// 					: 'Explore other brands',
					// 			),
					// 			const SizedBox(height: 8),
					// 			_buildSuggestionItem(
					// 				Icons.schedule_rounded,
					// 				'check_back_later'.tr.isNotEmpty 
					// 					? 'check_back_later'.tr 
					// 					: 'Check back later for updates',
					// 			),
					// 		],
					// 	),
					// ),
					const SizedBox(height: 20),
					
					// Action Buttons
					// Row(
					// 	children: [
					// 		Expanded(
					// 			child: OutlinedButton.icon(
					// 				onPressed: () {
					// 					Get.back();
					// 				},
					// 				icon: const Icon(Icons.arrow_back_ios_new, size: 16),
					// 				label: Text(
					// 					'go_back'.tr.isNotEmpty 
					// 						? 'go_back'.tr 
					// 						: 'Go Back',
					// 					style: const TextStyle(
					// 						fontWeight: FontWeight.w600,
					// 					),
					// 				),
					// 				style: OutlinedButton.styleFrom(
					// 					foregroundColor: Colors.grey.shade600,
					// 					side: BorderSide(color: Colors.grey.shade300, width: 1.5),
					// 					padding: const EdgeInsets.symmetric(vertical: 12),
					// 					shape: RoundedRectangleBorder(
					// 						borderRadius: BorderRadius.circular(12),
					// 					),
					// 				),
					// 			),
					// 		),
					// 		const SizedBox(width: 12),
					// 		Expanded(
					// 			child: ElevatedButton.icon(
					// 				onPressed: () {
					// 					// Refresh or navigate to search
					// 				},
					// 				icon: const Icon(Icons.search_rounded, size: 16),
					// 				label: Text(
					// 					'explore_brands'.tr.isNotEmpty 
					// 						? 'explore_brands'.tr 
					// 						: 'Explore Brands',
					// 					style: const TextStyle(
					// 						fontWeight: FontWeight.w600,
					// 						color: Colors.white,
					// 					),
					// 				),
					// 				style: ElevatedButton.styleFrom(
					// 					backgroundColor: accentColor,
					// 					foregroundColor: Colors.white,
					// 					padding: const EdgeInsets.symmetric(vertical: 12),
					// 					shape: RoundedRectangleBorder(
					// 						borderRadius: BorderRadius.circular(12),
					// 					),
					// 					elevation: 0,
					// 				),
					// 			),
					// 		),
					// 	],
					// ),
				],
			),
		);
	}

	Widget _buildSuggestionItem(IconData icon, String text) {
		return Row(
			children: [
				Icon(
					icon,
					size: 16,
					color: Colors.grey.shade600,
				),
				const SizedBox(width: 8),
				Expanded(
					child: Text(
						text,
						style: TextStyle(
							fontSize: 13,
							color: Colors.grey.shade700,
							height: 1.4,
						),
					),
				),
			],
		);
	}
}