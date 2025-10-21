import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/models/brand.dart';
import 'package:shop_app/core/res/app_colors.dart';

class BrandInfoCard extends StatelessWidget {
	const BrandInfoCard({super.key, required this.brand});

	final Brand brand;

	@override
	Widget build(BuildContext context) {
		

		return Container(
			padding: const EdgeInsets.only(top:16,left: 20,right:20,bottom:6),
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
											Get.locale?.languageCode == 'ar' ? brand.nameAr : brand.name,
											style: const TextStyle(
												fontSize: 20,
												fontWeight: FontWeight.w700,
											),
										),
										const SizedBox(height: 6),
										Row(
											children: [
												Icon(Icons.location_on_outlined,
														size: 18, color: iconColor ,
                                ),
												const SizedBox(width: 4),
												Expanded(
													child: Text(
														Get.locale?.languageCode == 'ar' ? brand.description : brand.descriptionEn,
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
					const SizedBox(height: 10),
			
				],
			),
		);
	}
}