import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/models/brand.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/core/animations/page_transitions.dart';
import 'package:shop_app/features/brand_reviews/brand_review.dart';

class BrandInfoCard extends StatelessWidget {
	const BrandInfoCard({super.key, required this.brand});

	final Brand brand;

	@override
	Widget build(BuildContext context) {
		return Container(
			padding: const EdgeInsets.only(top:16,left: 20,right:20,bottom:16),
			decoration: BoxDecoration(
				color: Colors.white,
				borderRadius: BorderRadius.circular(24),
				boxShadow: [
					BoxShadow(
						color: Colors.black.withOpacity(0.05),
						blurRadius: 18,
						offset: const Offset(0, 12),
					),
				],
			),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Row(
						crossAxisAlignment: CrossAxisAlignment.center,
						children: [
							CircleAvatar(
								radius: 32,
								backgroundColor: Colors.grey.shade200,
								backgroundImage:
										brand.image.isNotEmpty ? NetworkImage(brand.image) : null,
								child: brand.image.isEmpty
										? const Icon(Icons.storefront, size: 32, color: Colors.grey)
										: null,
							),
							const SizedBox(width: 16),
							Expanded(
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Text(
											Get.locale?.languageCode == 'ar' ? 
												(brand.nameAr.isEmpty ? brand.name : brand.nameAr) : 
												brand.name,
											style: const TextStyle(
												fontSize: 20,
												fontWeight: FontWeight.w700,
											),
										),
										const SizedBox(height: 6),
										Row(
											children: [
												Icon(Icons.location_on_outlined,
														size: 18, color: iconColor,
                                ),
												const SizedBox(width: 4),
												Expanded(
													child: Text(
														Get.locale?.languageCode == 'ar' ? 
															(brand.description.isEmpty ? brand.descriptionEn : brand.description) : 
															(brand.descriptionEn.isEmpty ? brand.description : brand.descriptionEn),
														style: const TextStyle(
															fontSize: 13,
															color: Colors.black54,
														),
													),
												),
											],
										),
									],
								),
							),
						],
					),
					const SizedBox(height: 12),
					
					// Rating and Reviews Section
					Row(
						children: [
							// Rating display
							if (brand.rating > 0) ...[
								Row(
									children: [
										Row(
											children: List.generate(5, (index) {
												return Icon(
													index < brand.rating.floor()
														? Icons.star
														: index < brand.rating
															? Icons.star_half
															: Icons.star_border,
													color: Colors.amber,
													size: 16,
												);
											}),
										),
										const SizedBox(width: 6),
										Text(
											brand.rating.toStringAsFixed(1),
											style: const TextStyle(
												fontSize: 14,
												fontWeight: FontWeight.w600,
												color: Colors.black87,
											),
										),
									],
								),
							] else ...[
								Row(
									children: [
										Row(
											children: List.generate(5, (index) {
												return Icon(
													Icons.star_border,
													color: Colors.grey[400],
													size: 16,
												);
											}),
										),
										const SizedBox(width: 6),
										Text(
											'no_ratings_yet'.tr,
											style: TextStyle(
												fontSize: 12,
												color: Colors.grey[600],
											),
										),
									],
								),
							],
							
							const SizedBox(width: 12),
							
							// Reviews button
							GestureDetector(
								onTap: () => AnimatedGet.toWithSlideRight(BrandReviewsView(brand: brand)),
								child: Container(
									padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
									decoration: BoxDecoration(
										color: primaryColor.withOpacity(0.1),
										borderRadius: BorderRadius.circular(20),
										border: Border.all(color: primaryColor.withOpacity(0.3)),
									),
									child: Row(
										mainAxisSize: MainAxisSize.min,
										children: [
											Icon(
												Icons.rate_review_outlined,
												size: 14,
												color: primaryColor,
											),
											const SizedBox(width: 4),
											Text(
												brand.reviewCount > 0 
													? '${brand.reviewCount} ${'reviews'.tr}'
													: 'view_reviews'.tr,
												style: TextStyle(
													fontSize: 12,
													color: primaryColor,
													fontWeight: FontWeight.w500,
												),
											),
										],
									),
								),
							),
						],
					),
			
				],
			),
		);
	}
}