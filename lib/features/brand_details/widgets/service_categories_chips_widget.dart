import 'package:flutter/material.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/features/brand_details/controllers/brand_details_controller.dart';

class ServiceCategoriesChipsWidget extends StatelessWidget {
	const ServiceCategoriesChipsWidget({super.key, required this.controller});

	final BrandDetailsController controller;

	@override
	Widget build(BuildContext context) {
		final accent = buttonColor is Color
				? buttonColor as Color
				: const Color(0xFFE47B39);

		final categories = controller.serviceCategories;
		if (categories.isEmpty) {
			return const SizedBox.shrink();
		}

		return Wrap(
			spacing: 12,
			runSpacing: 12,
			children: categories
					.map(
						(category) => Container(
							padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
							decoration: BoxDecoration(
								color: accent.withOpacity(.12),
								borderRadius: BorderRadius.circular(24),
							),
							child: Text(
								category,
								style: TextStyle(
									color: accent,
									fontWeight: FontWeight.w600,
								),
							),
						),
					)
					.toList(),
		);
	}
}